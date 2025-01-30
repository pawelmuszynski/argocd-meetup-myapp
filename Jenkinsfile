pipeline {
    agent any

    environment {
        IMAGE_NAME = 'pmuszynski/myapp'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
		script {
		  SHORT_COMMIT_HASH = sh(
		    script: 'git rev-parse --short HEAD',
                        returnStdout: true
		  ).trim()
		  echo "Short commit hash: ${SHORT_COMMIT_HASH}"
		}
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${SHORT_COMMIT_HASH} ."
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Logowanie do rejestru Docker (wymaga podania danych logowania w Jenkinsie)
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'

                    // Wypchnięcie obrazu do rejestru
                    sh "docker push ${IMAGE_NAME}:${SHORT_COMMIT_HASH}"
                }
            }
        }
    }

    post {
        always {
            // Wylogowanie z rejestru i czyszczenie
            sh 'docker logout'
        }
        success {
            echo 'Pipeline zakończony sukcesem!'
        }
        failure {
            echo 'Pipeline nie powiódł się.'
        }
    }
}
Ważne inf
