pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time:30, unit:'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Pick something')
    }
    stages {
        stage('Init') {
            steps {
                sh """
                 cd 01-vpc
                 terraform init -reconfigure
                """
            }
        }
        stage('Plan') {
            when {
                expression {
                    params.ACTION == 'Apply'
                }
            }
            steps {
                sh """
                 cd 01-vpc
                 terraform plan
                """
            }
        }
        stage('Deploy') {
             input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            when {
                expression {
                    params.ACTION == 'Apply'
                }
            }
            steps {
                sh """
                 cd 01-vpc
                 terraform apply -auto-approve
                """
            }
        }
        stage('Destroy') {
            when {
                expression {
                    params.ACTION == 'Destroy'
                }
            }
            steps {
                sh """
                 cd 01-vpc
                 terraform destroy -auto-approve
                """
            }
        }
    }
    post {
        always {
            echo "this will run always"
            deleteDir()
        }
        success {
            echo "this will run when pipeline is success"
        }
        failure {
            echo "this will run when pipeline is failed"
        }
    }
}