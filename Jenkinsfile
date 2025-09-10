pipeline {
    agent any
    stages {
        stage ('pull code form github') {
            steps{
                git branch: 'master' , url : 'https://github.com/rajeshark/terraform-s3-bucket-create-and-host-static-website-IAC-code-in-HCL--project.git'
            }
        }
   
         stage ('terraform apply & init'){
            steps{
                withAWS(credentials: 'aws-cred-rajesh' ,region:'eu-north-1'){
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
                }
            }
         }
        stage ('upload  files to s3 bucket automatically whenever we commit in github') {
            steps {
                withAWS(credentials: 'aws-cred-rajesh' region: 'eu-north-1'){
                sh 'aws s3 sync ./ s3://$(terraform output -raw name)'--exclude "*.tf" --exclude "Jenkinsfile"
            }
        }
    }
    post {
        success {
            echo 'static website deployment succesfull'
        }
        failure {
            echo 'static website deployment failure'
        }
    }
}
