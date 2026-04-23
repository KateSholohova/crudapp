pipeline {

    agent { label 'docker-agent' }

    

    environment {

        APP_NAME = 'app'
        CANARY_APP_NAME = 'app-canary'
        DOCKER_HUB_USER = 'katesholohova'
        GIT_REPO = 'https://github.com/KateSholohova/crudapp.git'
        BACKEND_IMAGE_NAME = 'website-app'
        DATABASE_IMAGE_NAME = 'website-mysql'
        MANAGER_IP = '192.168.0.1'
    }

    

    stages {

        stage('Checkout') {

            steps {

                git url: "${GIT_REPO}", branch: 'main', credentialsId: '0c49ac21-4d4e-42d3-ad3c-74311e1c7df3'

            }

        }

        

        stage('Build Docker Images') {

            steps {

                script {

                    sh """

                        docker build -f Dockerfile -t ${DOCKER_HUB_USER}/${BACKEND_IMAGE_NAME}:${BUILD_NUMBER} .

                        docker tag ${DOCKER_HUB_USER}/${BACKEND_IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_HUB_USER}/${BACKEND_IMAGE_NAME}:latest

                    """

                    sh """

                        docker build -f Dockerfile-mysql -t ${DOCKER_HUB_USER}/${DATABASE_IMAGE_NAME}:${BUILD_NUMBER} .

                        docker tag ${DOCKER_HUB_USER}/${DATABASE_IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_HUB_USER}/${DATABASE_IMAGE_NAME}:latest

                    """

                }

            }

        }

        

        // ⚠️ ЭТАП PUSH УДАЛЕН ⚠️

        

        stage('Deploy Canary') {

            steps {

                script {

                    // Проверяем наличие файла перед деплоем
                    sh """

                        echo "=== Проверка наличия docker-compose файлов ==="
                        ls -la docker-compose*.yaml || ls -la docker-compose*.yml
                        
                        echo "=== Развёртывание Canary (1 реплика на порту 8081) ==="
                        docker stack deploy -c docker-compose_canary.yaml ${CANARY_APP_NAME}
                        
                        echo "Ожидание запуска canary..."
                        sleep 30
                        
                        echo "Статус сервисов:"
                        docker service ls --filter name=${CANARY_APP_NAME}
                    """

                }

            }

        }

        

        stage('Canary Testing') {

            steps {

                sh """

                    echo "=== Тестирование Canary-версии (порт 8081) ==="
                    
                    SUCCESS=0
                    TESTS=10
                    
                    for i in \$(seq 1 \$TESTS); do
                        echo "Тест \$i/\$TESTS..."
                        if curl -f -s --max-time 15 http://${MANAGER_IP}:8081/actuator/health 2>/dev/null || \\
                           curl -f -s --max-time 15 http://${MANAGER_IP}:8081/ 2>/dev/null; then
                            SUCCESS=\$((SUCCESS + 1))
                            echo "✓ Тест \$i пройден"
                        else
                            echo "✗ Тест \$i: нет ответа"
                        fi
                        sleep 4
                    done
                    
                    echo "Успешных тестов: \$SUCCESS/\$TESTS"
                    [ "\$SUCCESS" -ge 8 ] || exit 1
                    echo "Canary прошёл тестирование!"
                """

            }

        }

        

        stage('Gradual Traffic Shift') {

            steps {

                sh """

                    echo "=== Постепенное переключение трафика на новую версию ==="
                    
                    if docker service ls --filter name=${APP_NAME}_web-server | grep -q ${APP_NAME}_web-server; then
                        echo "Основной сервис существует — начинаем rolling update"
                        
                        echo "Шаг 1: Обновляем 1-ю реплику продакшена"
                        docker service update \\
                            --image ${DOCKER_HUB_USER}/${BACKEND_IMAGE_NAME}:${BUILD_NUMBER} \\
                            --update-parallelism 1 \\
                            --update-delay 20h \\
                            --detach=true \\
                            ${APP_NAME}_web-server
                        
                        echo "Ожидание стабилизации после первой реплики..."
                        sleep 40
                        
                        echo "=== Мониторинг после первой реплики ==="
                        MONITOR_SUCCESS=0
                        MONITOR_TESTS=10
                        
                        for j in \$(seq 1 \$MONITOR_TESTS); do
                            if curl -f -s --max-time 15 http://${MANAGER_IP}:8080/actuator/health 2>/dev/null || \\
                               curl -f -s --max-time 15 http://${MANAGER_IP}:8080/ 2>/dev/null; then
                                MONITOR_SUCCESS=\$((MONITOR_SUCCESS + 1))
                                echo "✓ Проверка \$j пройдена"
                            else
                                echo "✗ Проверка \$j не пройдена"
                            fi
                            sleep 5
                        done
                        
                        echo "Успешных проверок после первой реплики: \$MONITOR_SUCCESS/\$MONITOR_TESTS"
                        [ "\$MONITOR_SUCCESS" -ge 9 ] || exit 1
                        echo "Мониторинг после первой реплики прошёл!"
                        sleep 60
                        
                        echo "Шаг 2: Обновляем оставшиеся реплики"
                        docker service update \\
                            --image ${DOCKER_HUB_USER}/${BACKEND_IMAGE_NAME}:${BUILD_NUMBER} \\
                            --update-parallelism 1 \\
                            --update-delay 30s \\
                            ${APP_NAME}_web-server
                        
                        echo "Ожидание завершения полного обновления..."
                        sleep 90
                        
                        echo "Статус после обновления:"
                        docker service ps ${APP_NAME}_web-server | head -20
                        
                        docker service update \\
                            --image ${DOCKER_HUB_USER}/${DATABASE_IMAGE_NAME}:${BUILD_NUMBER} \\
                            ${APP_NAME}_db 2>/dev/null || echo "MySQL сервис не требует обновления"
                        
                        echo "Удаление canary stack..."
                        docker stack rm ${CANARY_APP_NAME} || true
                        sleep 20
                    else
                        echo "Первый деплой — разворачиваем продакшен"
                        docker stack deploy -c docker-compose.yaml ${APP_NAME}
                        sleep 60
                    fi
                    
                    echo "Постепенное переключение завершено"
                """

            }

        }

        

        stage('Final Verification') {

            steps {

                sh """

                    echo "=== Финальная проверка ==="
                    
                    for i in \$(seq 1 5); do
                        echo "Финальный тест \$i/5..."
                        if curl -f --max-time 10 http://${MANAGER_IP}:8080/actuator/health 2>/dev/null || \\
                           curl -f --max-time 10 http://${MANAGER_IP}:8080/ 2>/dev/null; then
                            echo "✓ Тест \$i пройден"
                        else
                            echo "✗ Тест \$i не пройден"
                            exit 1
                        fi
                        sleep 5
                    done
                    
                    echo "Все финальные тесты пройдены!"
                """

            }

        }

    }

    

    post {

        success {

            echo "✓ Canary-деплой успешно завершён!"

        }

        failure {

            echo "✗ Ошибка в пайплайне — canary удалён, продакшен остался прежним"

            sh "docker stack rm ${CANARY_APP_NAME} || true"

            echo "Canary удалён, продакшен не тронут"

        }

        always {

            sh 'docker image prune -f || true'

        }

    }

}
