pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('Build WAR') {
            steps {
                // Use Maven to build the WAR file
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Ensure the WAR file is copied from target folder into Docker build context
                sh 'docker build -t dineshindupuri/studentsurveyform:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                // Use Docker credentials stored in Jenkins for login
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                // Push Docker image to Docker Hub
                sh 'docker push dineshindupuri/studentsurveyform:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Deploy the latest Docker image to Kubernetes
                sh '''
                    kubectl set image deployment/swe645assignment02-deployment container-0=dineshindupuri/studentsurveyform:latest -n default
                    kubectl rollout restart deploy swe645assignment02-deployment -n default
                '''
            }
        }
    }

    post {
        always {
            // Always log out from Docker Hub to avoid leaking credentials
            sh 'docker logout'
        }
    }
}
