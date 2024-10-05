pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-2'
    }

    stages {
        stage('AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args "--entrypoint=''"
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh '''
                        aws --version
                        aws ecs register-task-definition --cli-input-json file://AWS/task-definition.json
                        aws ecs update-service --cluster LearnJenkinsApp --service learnJenkinsApp --task-definition LearnJenkinsApp-TaskDefinition-Prod:2
                    '''
                }
            }
        }
    }
}
