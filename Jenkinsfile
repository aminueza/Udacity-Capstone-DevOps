pipeline {
    environment {
        dockerhubCredentials = 'dockerhub'
        dockerTag = "v1.2"
    }
    agent any
    stages {
        stage('Lint Dockerfile') {
            steps {
                script {
                    docker.image('hadolint/hadolint:latest-debian').inside() {
                        sh 'hadolint Dockerfile | tee -a hadolint_lint.txt'
                    }
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
        stage('Scan') {
            steps{
                aquaMicroscanner imageName: "aminueza/capstone-bcrypt:${dockerTag}", notCompliesCmd: 'exit 4', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
        // stage('Deploy') {
        //     steps {
        //     }
        // }
    }
}
