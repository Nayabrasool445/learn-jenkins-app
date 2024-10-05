pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION='us-east-2'
        AWS_ECS_CLUSTER='LearnJenkinsApp'
        AWS_ECS_SERVICE_PROD='learnJenkinsApp'
        AWS_ECS_TD_PROD='LearnJenkinsApp-TaskDefinition-Prod'

    }

    stages {
        stage('AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    reuseNode true
                    args "-u root --entrypoint=''"
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh '''
                        aws --version
                        yum install jq -y
                        LATEST_TD_REVISION=$(aws ecs register-task-definition --cli-input-json file://AWS/task-definition.json | jq '.taskDefinition.revision')
                        echo $LATEST_TD_REVISION
                        aws ecs update-service --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_PROD --task-definition $AWS_ECS_TD_PROD:$LATEST_TD_REVISION
                    '''
                }
            }
        }
    }
}
