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

        stage('Build and Push Docker Image') {
            steps {
	      script {
	          docker.withRegistry('https://docker.io/pmuszynski', 'dockerhubcreds') {
	              docker.build('myapp').push(${SHORT_COMMIT_HASH})
	          }
            }
	    }
        }

    }

    post {
        success {
            echo 'SUCCESS!'
        }
        failure {
            echo 'FAIL!'
        }
    }
}
