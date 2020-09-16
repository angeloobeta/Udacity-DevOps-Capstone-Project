pipeline {
     agent any
     stages {


        stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials:"capstone-project-user", region:"af-south-1") {
                      sh "eksctl create cluster --name capstonecluster"
                      sh "aws eks update-kubeconfig --name  capstonecluster --region af-south-1"
                      sh "kubectl get svc"
                      sh "kubectl set image deployments/django-capstone-project django-capstone-project=angeloobeta/django-capstone-project:latest"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/django-capstone-project"
                  }
              }
        }

        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
            }
        }
}
