pipeline {
     
   agent any
  
   environment{
      INT_FILE = fileExists "onlinestore-api/Interceptors"
      LIB_FILE = fileExists "onlinestore-api/libs"
      APINAME = "products-api"
      REPO="pubudu538/api-operator-demo"
   }
   
   stages {
      stage('Preparation') {   
         steps{
               git branch: "$APINAME",
               url: "https://github.com/${REPO}.git",
               credentialsId: 'github-dinusha'
         }
      }
       stage('Releasing a new API version to GitHub') {
         steps {
            echo "Deploying new version of API"
            withCredentials([usernamePassword(credentialsId: 'github-dinusha', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                sh 'sh /home/dinusha/scripts/git-release.sh $APINAME $USER $PASS $REPO'                        
            }
         }
      }     
     
      stage('Deploying API to Kubernetes') {
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

