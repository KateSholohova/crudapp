pipeline {
  agent { label 'docker-agent' }

  environment {
    DB_HOST = 'mysql'
    DB_PORT = '3306'
    DB_NAME = 'dorm'
    DB_USER = 'root'
    DB_PASSWORD = 'ydurada'
    EXPECTED_TABLES = '10'

    APP_NAME = 'app'
  }

  stages {

    stage('Checkout') {
      steps {
        git url: 'https://github.com/your-username/your-repo.git', branch: 'main'
      }
    }

    stage('Check DB Connection') {
      steps {
        sh '''
          echo "=== Checking MySQL connection ==="

          docker run --rm --network app_net mysql:8.0 \
            mysql -h mysql -u root -pydurada \
            -e "SELECT 1;"

          echo "=== Listing tables ==="

          docker run --rm --network app_net mysql:8.0 \
            mysql -h mysql -u root -pydurada \
            -D dorm -e "SHOW TABLES;"
        '''
      }
    }

    stage('Count Tables Validation') {
      steps {
        sh '''
          ACTUAL=$(docker run --rm --network app_net mysql:8.0 \
            mysql -h mysql -u root -pydurada \
            -D dorm -se "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='dorm';")

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

    stage('Build Image') {
      steps {
        sh '''
          docker build -t your-dockerhub-username/website-app:latest .
        '''
      }
    }

    stage('Push Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials',
          usernameVariable: 'USER',
          passwordVariable: 'PASS')]) {

          sh '''
            echo $PASS | docker login -u $USER --password-stdin
            docker push your-dockerhub-username/website-app:latest
          '''
        }
      }
    }

    stage('Deploy Stack') {
      steps {
        sh '''
          docker stack deploy -c docker-compose.yaml app --with-registry-auth
          sleep 30
        '''
      }
    }

    stage('Verify App') {
      steps {
        sh '''
          for i in 1 2 3 4 5; do
            if curl -f http://localhost:8080/actuator/health; then
              echo "OK"
              exit 0
            fi
            sleep 5
          done

          echo "FAILED"
          exit 1
        '''
      }
    }
  }

  post {
    always {
      sh 'docker image prune -f || true'
    }
  }
}
