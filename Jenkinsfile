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
	      docker.withRegistry('https://docker.io/pmuszynski', 'dockerhubcreds') {
	          docker.build('myapp').push(${SHORT_COMMIT_HASH})
//                    sh "docker build -t ${IMAGE_NAME}:${SHORT_COMMIT_HASH} ."
	      }
            }
	    }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh "docker push ${IMAGE_NAME}:${SHORT_COMMIT_HASH}"
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
        success {
            echo 'SUCCESS!'
        }
        failure {
            echo 'FAIL!'
        }
    }
}
