pipeline {
    agent any  // This will run the pipeline on any available agent

    stages {
        stage('Build') {
            steps {
                // Your build steps go here. For example, if you're using a build.ps1 script:
                echo 'Build stage succeeded'
            }
        }

        stage('Test') {
            steps {
                // Your test steps go here. For example, if you have a test.ps1 script:
                echo 'Test stage succeeded'
            }
        }

        stage('Deploy') {
            steps {
                // Your deployment steps go here. For example, if you have a deploy.ps1 script:
                echo 'Deploy stage succeeded'
            }
        }
    }

    post {
        always {
            // This block will always execute, regardless of the pipeline success/failure
            echo 'This will always run'
        }

        success {
            // This block will only execute if the pipeline was successful
            echo 'Pipeline was successful!'
        }

        failure {
            // This block will only execute if the pipeline failed
            echo 'Pipeline failed.'
        }
    }
}
