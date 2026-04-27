pipeline {
  agent any

  environment {
    DB_HOST = 'mysql'
    DB_PORT = '3306'
    DB_NAME = 'dorm'
    DB_USER = 'root'
    DB_PASSWORD = 'ydurada'
    EXPECTED_TABLES = '10'

    MANAGER_IP = 'localhost'
  }

  stages {

    stage('Checkout') {
      steps {
        git url: 'https://github.com/KateSholohova/crudapp.git', branch: 'main'
      }
    }

    stage('Check DB Connection') {
      steps {
        sh '''
          echo "=== Checking MySQL connection ==="

          docker run --rm --network app_net mysql:8.0 \
            mysql -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} \
            -e "SELECT 1;"

          if [ $? -ne 0 ]; then
            echo "❌ DB connection failed"
            exit 1
          fi

          echo "=== Listing tables ==="

          docker run --rm --network app_net mysql:8.0 \
            mysql -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} \
            -D ${DB_NAME} -e "SHOW TABLES;"
        '''
      }
    }

    stage('Validate Tables Count') {
      steps {
        sh '''
          echo "=== Counting tables ==="

          ACTUAL=$(docker run --rm --network app_net mysql:8.0 \
            mysql -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} \
            -D ${DB_NAME} \
            -se "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")

          echo "Expected: ${EXPECTED_TABLES}"
          echo "Actual: $ACTUAL"

          if [ "$ACTUAL" -ne "${EXPECTED_TABLES}" ]; then
            echo "❌ Table count mismatch"
            exit 1
          fi

          echo "✅ DB OK"
        '''
      }
    }

    stage('Deploy Stack') {
      steps {
        sh '''
          echo "=== Deploying stack ==="

          docker stack deploy -c docker-compose.yaml app --with-registry-auth

          echo "Waiting for services..."
          sleep 40

          docker service ls
        '''
      }
    }

    stage('Verify App') {
      steps {
        sh '''
          echo "=== Verifying application ==="

          for i in 1 2 3 4 5; do
            echo "Attempt $i..."

            if curl -f http://${MANAGER_IP}:8080/actuator/health; then
              echo "✅ Application is healthy"
              exit 0
            fi

            sleep 5
          done

          echo "❌ Application is not responding"
          exit 1
        '''
      }
    }
  }

  post {
    success {
      echo "✅ Pipeline completed successfully"
    }

    failure {
      echo "❌ Pipeline failed"
    }

    always {
      sh 'docker image prune -f || true'
    }
  }
}
