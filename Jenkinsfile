pipeline {
     
   agent any
  
   environment{
      INT_FILE = fileExists "onlinestore-api/Interceptors"
      LIB_FILE = fileExists "onlinestore-api/libs"
      APINAME = "newsample"
   }
   
   stages {
      stage('Preparation') {   
         steps{
               git branch: 'onlinestore-api',
               url: 'https://github.com/dinusha92/test.git',
               credentialsId: 'github-dinusha'
         }
      }
       stage('Releasing a new API version') {
         steps {
            echo "Deploying new version of API"
            withCredentials([usernamePassword(credentialsId: 'github-dinusha', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                sh 'sh /home/dinusha/scripts/git-release.sh $APINAME $USER $PASS'                        
            }
            sh 'sh /home/dinusha/scripts/git-release.sh $APINAME'
         }
      }     
      stage('Preparing structure') {
         when { expression { INT_FILE == 'false' } }
         steps {
            sh 'mkdir onlinestore-api/Interceptors'
         }
      }
      stage('Preparing Structure'){
         when { expression { LIB_FILE == 'false' } }
            steps {
               sh 'mkdir onlinestore-api/libs'
            }
      }
      stage('Deploying to Kubernetes') {
         steps {
            echo "Deploying to Kubernetes"
            sh 'apictl set --mode k8s'
            sh 'sh /home/dinusha/scripts/deploying-api.sh $APINAME'
         }
      }
   }
   
   post {
      always { 
         cleanWs()
      }
    }
}

