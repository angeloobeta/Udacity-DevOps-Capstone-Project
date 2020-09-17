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

        stage('Lint Dockerfile') {
        steps {
            script {
                docker.image('hadolint/hadolint:latest-debian').inside() {
                        sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
                        sh '''
                            lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
                            if [ "$lintErrors" -gt "0" ]; then
                                echo "Errors have been found, please see below"
                                cat hadolint_lint.txt
                                exit 1
                            else
                                echo "There are no erros found on Dockerfile!!"
                            fi
                        '''
                        }
                    }
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
                      sh "aws eks --region af-south-1 update-kubeconfig --name capstonecluster" 
                      sh "kubectl config use-context arn:aws:eks:af-south-1:761971665763:cluster/capstonecluster"
                      sh "kubectl set image deployments/django-capstone-project django-capstone-project=angeloobeta/django-capstone-project:latest"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl deployment"
                      sh "kubectl get svc"
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

eksctl create cluster --name capstonecluster --region