pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-north-1'
        AWS_ACCESS_KEY_ID = 'AKIA3JIW32I5RWXAD'
        AWS_SECRET_ACCESS_KEY = 'PELbv3M7ZzLEe0itHStECk/dQbK/9uxorMQr/tNA'


    }
    stages {
        stage ('pull code form github') {
            steps{
                git branch: 'master' , url : 'https://github.com/rajeshark/terraform-s3-bucket-create-and-host-static-website-IAC-code-in-HCL--project.git'
            }
        }
   
         stage ('terraform apply & init'){
            steps{
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
            }
        }
    
        stage ('upload  files to s3 bucket automatically whenever we commit in github') {
            steps {
                sh 'aws s3 sync ./ s3://$(terraform output -raw name)'
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
