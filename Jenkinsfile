pipeline {
    agent any
    stages {
        stage ('pull code from github') {
            steps{
                git branch: 'master', url: 'https://github.com/rajeshark/terraform-s3-bucket-create-and-host-static-website-IAC-code-in-HCL--project.git'
            }
        }
   
        stage ('terraform apply & init') {
            steps {
                withAWS(credentials: 'aws-cred-rajesh', region: 'eu-north-1') {
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        
        stage ('upload files to s3 bucket') {
            steps {
                withAWS(credentials: 'aws-cred-rajesh', region: 'eu-north-1') {
                    // Extract just the bucket name (part before first dot)
                    sh '''
                        BUCKET_NAME=$(terraform output -raw name | cut -d'.' -f1)
                        aws s3 sync ./ s3://$BUCKET_NAME --exclude "*.tf" --exclude "Jenkinsfile" --exclude ".lock.hcl"
--exclude ".git" --exclude ".terraform" --exclude ".md"                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo 'static website deployment successful'
            echo '$(terraform output -raw name')
        }
        failure {
            echo 'static website deployment failure'
        }
    }
}
