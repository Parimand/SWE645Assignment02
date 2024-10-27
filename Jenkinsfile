//Group member details
/* Pavan Sai Gopinadh Reddy Arimanda G01478272
Venkat Dinesh Indupuri  
Nemali Sudheer Reddy
Datta Naga Vamseedhar Gunnampalli
*/


// This Jenkins pipeline automates the build, push, and deployment process for a web application.
// It includes stages to build a WAR file, create a Docker image, push the image to Docker Hub
// update the Kubernetes deployment to use the latest image. Docker login/logout is handled securely using Jenkins credentials.
pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('Build WAR') {
            steps {
                // Clean up any existing WAR files if necessary
                sh 'rm -rf target/studentsurveyform.war'
                
                // Create the WAR file from the webapp directory
                sh 'jar -cvf target/studentsurveyform.war -C "src/main/webapp" .'
                
                // Build the Docker image using the Dockerfile
                sh 'docker build --no-cache -t dineshindupuri/studentsurveyform:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                // Push the built image to Docker Hub
                sh 'docker push dineshindupuri/studentsurveyform:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Update the Kubernetes deployment to use the new image
                sh 'kubectl set image deployment/assignment02 container-0=dineshindupuri/studentsurveyform:latest -n default'
                sh 'kubectl rollout restart deployment/assignment02 -n default'
            }
        }
    }

    post {
        always {
            // Ensure Docker logout happens after each run
            sh 'docker logout'
        }
    }
}
