pipeline {
    agent any

    environment {
        IMAGE_NAME = 'pmuszynski/myapp'
    }

    stages {
        stage('Install docker') {
	  steps {
	    sh 'apt update'
	    sh 'apt install -y docker.io'
	  }
	}
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
	              docker.build('myapp', "--build-arg BUILD_VERSION=${SHORT_COMMIT_HASH}").push(${SHORT_COMMIT_HASH})
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
