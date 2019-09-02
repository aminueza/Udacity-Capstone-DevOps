pipeline {
    environment {
        dockerhubCredentials = 'dockerhub'
        dockerTag = $(date +%Y%m%d).$BUILD_NUMBER
    }
    agent any
    stages {
        stage('Lint Dockerfile') {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'
                    }
            }
            steps {
                sh 'hadolint Dockerfile | tee -a hadolint_lint.txt'
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("aminueza/capstone-bcrypt:${dockerTag}")
                    docker.withRegistry('', dockerhubCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
            }
        }
    }
}
