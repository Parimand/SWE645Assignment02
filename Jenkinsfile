pipeline{
    agent any
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}
  stages{
    stage('Build') {
      steps {
	sh 'echo "Current directory contents:"'
        sh 'ls -la'
        sh 'echo "Git commit hash:"'
        sh 'git rev-parse HEAD'
	sh 'rm -rf *.var'
        sh 'jar -cvf studentsurveyform.war -C "src/main/webapp" .'     
        sh 'docker build -t dineshindupuri/studentsurveyform:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW |docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
       }
    }
    stage("Push image to docker hub"){
      steps {
        sh 'docker push dineshindupuri/studentsurveyform:latest'
      }
    }
        stage("deploying on k8")
	{
		steps{
			sh 'kubectl set image deployment/swe645assignment02-deployment container-0=dineshindupuri/studentsurveyform:latest -n default'
			sh 'kubectl rollout restart deploy swe645assignment02-deployment -n default'
		}
	} 
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}
