pipeline {
    environment {
        dockerhubCredentials = 'dockerhub'
    }
    agent any
    stages {
        stage('Lint Dockerfile') {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'
                }
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'

                }

            }
            steps {
                sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
                sh '''
                lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
                if [ "$lintErrors" -gt "0" ]; then
                    echo "Linting Errors, please see below"
                    cat hadolint_lint.txt
                    exit 1
                else
                    echo "Dockerfile is valid!!"
                fi
                '''
            }
        }
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("aminueza/capstone-bcrypt:${env.BUILD_NUMBER}")
                    docker.withRegistry('', dockerhubCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Scan Dockerfile') {
            steps{
                aquaMicroscanner imageName: "aminueza/capstone-bcrypt:${env.BUILD_NUMBER}", notCompliesCmd: 'exit 4', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
        // stage('Deploy') {
        //     steps {
        //     }
        // }
    }
}
