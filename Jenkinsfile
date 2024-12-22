pipeline{
    agent any

   parameters {
        choice(
            name: 'apply_or_destroy',
            choices: ['apply', 'destroy']
        )
    }
    
    stages{

    stage('check if vpc exist'){ 
            steps {
                script {
                    def cidrBlock = "10.0.0.0/16"
                    def region = "us-west-2"
                    def vpcCheck = sh(script: """
                        aws ec2 describe-vpcs --region ${region} \
                        --filters Name=cidr-block,Values=${cidrBlock} \
                        --query 'Vpcs[?State==`available`].VpcId' --output text
                    """, returnStdout: true).trim()

                    if (vpcCheck) {
                        echo "VPC found: ${vpcCheck}"
                    } else {
                        echo "No VPC with CIDR ${cidrBlock} found in region ${region}."
                    }
                }
            }
        }
    
    stages {
        stage('Check and Create DynamoDB Table') {
            steps {
                script {
                    def tableName = "existing-table-name"
                    def newTableName = "new-table-name"
                    def region = "us-west-2"

                    // Check if the table exists
                    def tableCheck = sh(script: """
                        aws dynamodb describe-table --table-name ${tableName} --region ${region} 2>/dev/null && echo "exists" || echo "not-exist"
                    """, returnStdout: true).trim()

                    // If table exists, create a new one
                    if (tableCheck == "exists") {
                        echo "Table '${tableName}' exists. Creating a new table '${newTableName}'."
                        sh """
                            aws dynamodb create-table \
                            --table-name ${newTableName} \
                            --attribute-definitions AttributeName=LockID,AttributeType=S \
                            --key-schema AttributeName=LockID,KeyType=HASH \
                            --billing-mode PAY_PER_REQUEST \
                            --region ${region}
                        """
                    } else {
                        echo "Table '${tableName}' does not exist. No action needed."
                    }
                }
            }
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
    success {
        echo "Pipeline succeeded. Sending success notification."
        // Send success email notification
        mail(
            to: 'recipient@example.com',
            subject: "Pipeline Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: """\
            The pipeline ${env.JOB_NAME} (build #${env.BUILD_NUMBER}) has completed successfully.

            All steps executed successfully.

            Pipeline URL: ${env.BUILD_URL}
            """
        )
    }

    failure {
        echo "Pipeline failed. Attempting cleanup..."
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            sh "terraform destroy -auto-approve || echo 'Terraform destroy failed, but continuing...'"
            echo "Can't create env, so all resources are being deleted."
        }

        // Send failure email notification
        mail(
            to: 'recipient@example.com',
            subject: "Pipeline Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: """\
            The pipeline ${env.JOB_NAME} (build #${env.BUILD_NUMBER}) has failed.

            Cleanup has been attempted using Terraform destroy. Please check the logs for more details.

            Pipeline URL: ${env.BUILD_URL}
            """
            )
        }
    }
}