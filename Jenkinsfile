pipeline {
    agent any

    environment {
        DB_HOST = 'db'
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

                        echo "✓ Проверка Docker:"
                        docker --version

                        echo "✓ Проверка подключения к MySQL:"

                        docker run --rm --network jenkins_net mysql:8.0 \
                        mysql -h ${DB_HOST} -P ${DB_PORT} \
                        -u ${DB_USER} -p${DB_PASSWORD} \
                        -e "SELECT 1;" 2>&1

                        if [ $? -ne 0 ]; then
                            echo "❌ НЕ УДАЛОСЬ ПОДКЛЮЧИТЬСЯ К БД!"
                            exit 1
                        fi

                        echo "📋 Таблицы:"
                        docker run --rm --network jenkins_net mysql:8.0 \
                        mysql -h ${DB_HOST} -P ${DB_PORT} \
                        -u ${DB_USER} -p${DB_PASSWORD} \
                        -D ${DB_NAME} \
                        -e "SHOW TABLES;"

                        echo "📊 Подсчет таблиц:"

                        ACTUAL_TABLES=$(docker run --rm --network jenkins_net mysql:8.0 \
                        mysql -h ${DB_HOST} -P ${DB_PORT} \
                        -u ${DB_USER} -p${DB_PASSWORD} \
                        -D ${DB_NAME} \
                        -se "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")

                        echo "Ожидаемое: ${EXPECTED_TABLES}"
                        echo "Фактическое: $ACTUAL_TABLES"

                        if [ "$ACTUAL_TABLES" -eq "${EXPECTED_TABLES}" ]; then
                            echo "✅ OK"
                        else
                            echo "❌ НЕ СОВПАДАЕТ!"
                            exit 1
                        fi
                    '''
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    echo "🚀 Деплой..."
                    docker stack deploy -c docker-compose.yaml app
                    sleep 20
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    for i in 1 2 3 4 5; do
                        if curl -f http://localhost:8080/actuator/health; then
                            echo "✅ OK"
                            exit 0
                        fi
                        sleep 10
                    done

                    echo "❌ Не работает"
                    exit 1
                '''
            }
        }
    }
}
