pipeline {
    agent { label 'swarm-cloud' }
    
    environment {
        DB_HOST = '192.168.0.1'
        DB_PORT = '3306'
        DB_NAME = 'dorm'
        DB_USER = 'root'
        DB_PASSWORD = 'ydurada'
        EXPECTED_TABLES = '10'
    }
    
    stages {
        stage('Check Tables Count in DORM Database') {
            steps {
                script {
                    sh '''
                        echo "═══════════════════════════════════════════════"
                        echo "   ПРОВЕРКА БАЗЫ ДАННЫХ DORM"
                        echo "═══════════════════════════════════════════════"
                        echo ""
                        
                        # Проверка 1: Доступность Docker
                        echo "✓ Проверка Docker:"
                        docker --version
                        echo ""
                        
                        # Проверка 2: Доступность образа mysql
                        echo "✓ Проверка образа mysql:"
                        docker pull mysql:8.0 2>/dev/null || true
                        echo ""
                        
                        # Проверка 3: Подключение к БД
                        echo "✓ Проверка подключения к MySQL:"
                        docker run --rm mysql:8.0 mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -e "SELECT 1;" 2>&1
                        if [ $? -ne 0 ]; then
                            echo "❌ НЕ УДАЛОСЬ ПОДКЛЮЧИТЬСЯ К БД!"
                            echo "   Проверьте:"
                            echo "   - Хост: ${DB_HOST}"
                            echo "   - Порт: ${DB_PORT}"
                            echo "   - Пароль: ${DB_PASSWORD}"
                            exit 1
                        fi
                        echo ""
                        
                        # Проверка 4: Список всех таблиц
                        echo "📋 Список всех таблиц в базе ${DB_NAME}:"
                        docker run --rm mysql:8.0 mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME} -e "SHOW TABLES;" 2>&1
                        echo ""
                        
                        # Проверка 5: Подсчет количества таблиц
                        echo "📊 ПОДСЧЕТ ТАБЛИЦ:"
                        ACTUAL_TABLES=$(docker run --rm mysql:8.0 mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME} -se "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '${DB_NAME}';" 2>/dev/null)
                        
                        # Проверка, что переменная не пустая
                        if [ -z "$ACTUAL_TABLES" ]; then
                            echo "❌ НЕ УДАЛОСЬ ПОЛУЧИТЬ КОЛИЧЕСТВО ТАБЛИЦ!"
                            echo "   Возможно, база данных '${DB_NAME}' не существует"
                            exit 1
                        fi
                        
                        echo "   Ожидаемое количество: ${EXPECTED_TABLES}"
                        echo "   Фактическое количество: $ACTUAL_TABLES"
                        echo ""
                        
                        # Финальная проверка
                        if [ "$ACTUAL_TABLES" -eq "${EXPECTED_TABLES}" ]; then
                            echo "✅ РЕЗУЛЬТАТ: УСПЕШНО"
                            echo "   Все ${EXPECTED_TABLES} таблиц на месте!"
                            exit 0
                        elif [ "$ACTUAL_TABLES" -lt "${EXPECTED_TABLES}" ]; then
                            echo "❌ РЕЗУЛЬТАТ: ОШИБКА"
                            echo "   Обнаружено МЕНЬШЕ таблиц ($ACTUAL_TABLES) чем требуется (${EXPECTED_TABLES})"
                            echo "   ❌ ДЕПЛОЙ ЗАБЛОКИРОВАН!"
                            exit 1
                        else
                            echo "⚠️ РЕЗУЛЬТАТ: ПРЕДУПРЕЖДЕНИЕ"
                            echo "   Обнаружено БОЛЬШЕ таблиц ($ACTUAL_TABLES) чем ожидалось (${EXPECTED_TABLES})"
                            exit 1
                        fi
                    '''
                }
            }
        }
        
        stage('Deploy Application') {
            steps {
                echo "═══════════════════════════════════════════════"
                echo "🚀 НАЧАЛО ДЕПЛОЯ"
                echo "═══════════════════════════════════════════════"
                sh '''
                    echo "Развертывание основного приложения..."
                    docker stack deploy -c docker-compose.yaml app
                    
                    echo "Ожидание запуска контейнеров..."
                    sleep 30
                    
                    echo "✅ Деплой успешно завершен!"
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo "=== ФИНАЛЬНАЯ ПРОВЕРКА ==="
                sh '''
                    echo "Проверка доступности приложения..."
                    
                    for i in 1 2 3 4 5; do
                        if curl -f -s --max-time 10 http://${DB_HOST}:8080/actuator/health 2>/dev/null; then
                            echo "✅ Приложение работает!"
                            exit 0
                        elif curl -f -s --max-time 10 http://${DB_HOST}:8080/ 2>/dev/null; then
                            echo "✅ Приложение работает!"
                            exit 0
                        fi
                        echo "Ожидание приложения... попытка $i/5"
                        sleep 10
                    done
                    
                    echo "❌ Приложение не отвечает"
                    exit 1
                '''
            }
        }
    }
    
    post {
        success {
            echo "═══════════════════════════════════════════════"
            echo "🎉 ПАЙПЛАЙН УСПЕШНО ЗАВЕРШЕН!"
            echo "═══════════════════════════════════════════════"
            echo "   ✅ Проверка таблиц: ${EXPECTED_TABLES} из ${EXPECTED_TABLES}"
            echo "   ✅ Деплой выполнен"
            echo "   ✅ Приложение работает"
        }
        failure {
            echo "═══════════════════════════════════════════════"
            echo "💀 ПАЙПЛАЙН ПРОВАЛЕН!"
            echo "═══════════════════════════════════════════════"
            echo "   ❌ Проверка таблиц не пройдена"
            echo "   ❌ Деплой НЕ выполнен"
            echo ""
            echo "📝 ДЛЯ ИСПРАВЛЕНИЯ:"
            echo "   1. Проверьте доступность БД: mysql -h ${DB_HOST} -u ${DB_USER} -p -e 'SHOW DATABASES;'"
            echo "   2. Убедитесь, что база '${DB_NAME}' существует"
            echo "   3. Проверьте количество таблиц: должно быть ${EXPECTED_TABLES}"
            echo "   4. Восстановите недостающие таблицы из дампа"
        }
    }
}
