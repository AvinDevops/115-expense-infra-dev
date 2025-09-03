pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time:30, unit:'MINUTES')
        disableConcurrentBuilds()
    }
    stages {
        stage('Init') {
            steps {
                sh """
                 ls -ltr
                """
            }
        }
        stage('Plan') {
            steps {
                echo 'This is Test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'This is Deploy'
            }
        }
    }
    post {
        always {
            echo "this will run always"
        }
        success {
            echo "this will run when pipeline is success"
        }
        failure {
            echo "this will run when pipeline is failed"
        }
    }
}