pipeline {
    agent any

    stages {
        stage('AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args "--entrypoint=''"
                }
            }
            environment {
                AWS_S3_BUCKET = 'nayab-rasool-demo-bucket'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh '''
                        aws --version
                        aws ecs register-task-definition --cli-input-json file://AWS/task-definition.json
                    '''
                }
            }
        }
    }
}
