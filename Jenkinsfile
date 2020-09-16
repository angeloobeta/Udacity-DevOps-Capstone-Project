pipeline {
     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }

    
         stage('Build Docker Image') {
              steps {
                  sh 'docker build -t django-capstone-project .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
                      sh "docker tag django-capstone-project angeloobeta/django-capstone-project"
                      sh "docker push angeloobeta/django-capstone-project"
                  }
              }
         }

        stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials:"capstone-project-user", region:"af-south-1") {
                      // sh "eksctl create cluster --name  capstonecluster --region af-south-1"
                      sh "aws eks --region af-south-1 update-kubeconfig --name capstonecluster"
                      sh "kubectl get svc"
                      sh "kubectl config use-context arn:aws:eks:af-south-1:761971665763:cluster/capstonecluster"
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
