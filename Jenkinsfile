pipeline{
    agent any
    environment{
        terraform = "terraform 1.5.0"
    }
   parameters {
        choice(
            name: 'apply_or_destroy',
            choices: ['apply', 'destroy']
        )
    }
    
    stages{
    
    stage('create dynamodb to store lock file'){
        steps{
                sh "aws dynamodb create-table --table-name terraform-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --tags Key=Environment,Value=Production Key=Purpose,Value=TerraformStateLocking --region us-west-2"
            }
    }

    stage('tf init'){
        steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform init -upgrade -reconfigure"
            sh "echo execute terraform init"
          }
        }
    }

    stage('terraform apply or destroy'){
        steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform ${params.apply_or_destroy} -auto-approve"
            sh "echo ${params.apply_or_destroy} "
        }
      }
    }
  }

  post {
    failure {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform destroy -auto-approve"
            sh "Can't create env, so delete all the resources"
          }
        }
    }
}