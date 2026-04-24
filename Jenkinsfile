pipeline {
     agent { label 'docker-agent' }
    
    environment {
        DB_HOST = '192.168.0.1'
        DB_PORT = '3306'
        DB_NAME = 'dorm'
        DB_USER = 'root'
        DB_PASSWORD = 'ydurada'
        EXPECTED_TABLES = '10'   // ← Теперь 10 таблиц
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/KateSholohova/crudapp.git', 
                    branch: 'main', 
                    credentialsId: '0c49ac21-4d4e-42d3-ad3c-74311e1c7df3'
            }
        }
        
        stage('Check Tables Count in DORM Database') {
            steps {
                script {
                    sh '''
                        echo "═══════════════════════════════════════════════"
                        echo "   ПРОВЕРКА БАЗЫ ДАННЫХ DORM"
                        echo "═══════════════════════════════════════════════"
                        
                        echo ""
                        echo "Список всех таблиц:"
                        docker run --rm mysql:8.0 mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME} -se "SHOW TABLES;" 2>/dev/null
                        
                        echo ""
                        echo "ПОДСЧЕТ ТАБЛИЦ:"
                        ACTUAL_TABLES=$(docker run --rm mysql:8.0 mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME} -se "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '${DB_NAME}';" 2>/dev/null)
                        
                        echo "   Ожидаемое количество: ${EXPECTED_TABLES}"
                        echo "   Фактическое количество: $ACTUAL_TABLES"
                        echo ""
                        
                        # Сравнение
                        if [ "$ACTUAL_TABLES" -eq "${EXPECTED_TABLES}" ]; then
                            echo "РЕЗУЛЬТАТ: УСПЕШНО"
                            exit 0
                        elif [ "$ACTUAL_TABLES" -lt "${EXPECTED_TABLES}" ]; then
                            echo "РЕЗУЛЬТАТ: ОШИБКА"
                            echo "   Обнаружено МЕНЬШЕ таблиц ($ACTUAL_TABLES) чем требуется (${EXPECTED_TABLES})"
                            exit 1
                        else
                            echo "РЕЗУЛЬТАТ: ПРЕДУПРЕЖДЕНИЕ"
                            echo "   Обнаружено БОЛЬШЕ таблиц ($ACTUAL_TABLES) чем ожидалось (${EXPECTED_TABLES})"
                            exit 1
                        fi
                    '''
                }
            }
        }
        
        stage('Deploy Application') {
            steps {
                echo "НАЧАЛО ДЕПЛОЯ..."
                sh '''
                    echo "Развертывание основного приложения..."
                    docker stack deploy -c docker-compose.yaml app
                    
                    echo "Ожидание запуска..."
                    sleep 30
                    
                    echo "Деплой успешно завершен!"
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo "=== ФИНАЛЬНАЯ ПРОВЕРКА ==="
                sh '''
                    # Проверка доступности приложения
                    for i in 1 2 3 4 5; do
                        if curl -f -s http://${DB_HOST}:8080/actuator/health 2>/dev/null; then
                            echo "Приложение работает!"
                            exit 0
                        fi
                        echo "Ожидание приложения... попытка $i/5"
                        sleep 10
                    done
                    
                    echo "Приложение не отвечает"
                    exit 1
                '''
            }
        }
    }
    
    post {
        success {
            echo "═══════════════════════════════════════════════"
            echo "ПАЙПЛАЙН УСПЕШНО ЗАВЕРШЕН!"
            echo "═══════════════════════════════════════════════"

        }
        failure {
            echo "═══════════════════════════════════════════════"
            echo "ПАЙПЛАЙН ПРОВАЛЕН!"
            echo "═══════════════════════════════════════════════"

        }
    }
}
