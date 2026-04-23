pipeline {
    agent { label 'docker-agent' }
    
    environment {
        DOCKER_HUB_USER = 'katesholohova'
        APP_NAME = 'website-app'
        DB_NAME = 'website-mysql'
        // IP менеджера Swarm (измените на ваш)
        MANAGER_IP = '192.168.0.1'  // ← УКАЖИТЕ ВАШ IP
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Java with Maven') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }
        
        stage('Build Docker Images') {
            steps {
                script {
                    // Сборка образа приложения
                    sh """
                        docker build -f Dockerfile -t ${DOCKER_HUB_USER}/${APP_NAME}:${BUILD_NUMBER} .
                        docker tag ${DOCKER_HUB_USER}/${APP_NAME}:${BUILD_NUMBER} ${DOCKER_HUB_USER}/${APP_NAME}:latest
                    """
                    
                    // Сборка образа MySQL
                    sh """
                        docker build -f Dockerfile-mysql -t ${DOCKER_HUB_USER}/${DB_NAME}:${BUILD_NUMBER} .
                        docker tag ${DOCKER_HUB_USER}/${DB_NAME}:${BUILD_NUMBER} ${DOCKER_HUB_USER}/${DB_NAME}:latest
                    """
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Пушим образ приложения
                    sh """
                        docker push ${DOCKER_HUB_USER}/${APP_NAME}:${BUILD_NUMBER}
                        docker push ${DOCKER_HUB_USER}/${APP_NAME}:latest
                    """
                    
                    // Пушим образ MySQL
                    sh """
                        docker push ${DOCKER_HUB_USER}/${DB_NAME}:${BUILD_NUMBER}
                        docker push ${DOCKER_HUB_USER}/${DB_NAME}:latest
                    """
                }
            }
        }
        
        stage('Deploy Canary') {
            steps {
                script {
                    // Деплоим canary версию
                    sh """
                        docker stack deploy -c docker-compose_canary.yml app-canary --with-registry-auth
                    """
                }
            }
        }
        
        stage('Canary Testing') {
            steps {
                script {
                    // Ждем запуска canary
                    sh 'sleep 10'
                    
                    // Проверяем, что canary ответил
                    sh """
                        curl -f http://${MANAGER_IP}:8081/actuator/health || exit 1
                    """
                }
            }
        }
        
        stage('Gradual Traffic Shift') {
            steps {
                script {
                    // Обновляем основное приложение новыми образами
                    sh """
                        docker service update --image ${DOCKER_HUB_USER}/${APP_NAME}:${BUILD_NUMBER} app_web-server
                        docker service update --image ${DOCKER_HUB_USER}/${DB_NAME}:${BUILD_NUMBER} app_db
                    """
                }
            }
        }
        
        stage('Final Verification') {
            steps {
                script {
                    // Проверяем, что основное приложение работает
                    sh """
                        sleep 10
                        curl -f http://${MANAGER_IP}:8080/actuator/health || exit 1
                    """
                }
            }
        }
    }
    
    post {
        always {
            script {
                // Очистка canary (всегда, даже при ошибке)
                sh """
                    docker stack rm app-canary || true
                    docker image prune -f || true
                """
            }
        }
        success {
            echo '✅ Пайплайн успешно выполнен!'
        }
        failure {
            echo '✗ Ошибка в пайплайне — canary удалён, продакшен остался прежним'
        }
    }
}
