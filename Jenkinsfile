pipeline {
    agent any

    environment {
        registry = "swarajtandel/myapp"      // Docker Hub username/repo
        registryCredential = 'dockerhub'     // Must match the Jenkins credential ID
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                // Clone the main branch of your GitHub repo
                git branch: 'main', url: 'https://github.com/swarajtandel/DSO-Lab6.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    // Build Docker image using root directory as context
                    dockerImage = docker.build registry, '.'
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    // Trivy security scan for Docker image
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image ${registry}'
                }
            }
        }

        stage('Deploying Image') {
            steps {
                script {
                    // Push Docker image to Docker Hub using Jenkins credentials
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                // Remove local Docker image to free space
                sh "docker rmi ${registry}"
            }
        }
    }

    post {
        always {
            // Clean workspace after every build
            cleanWs()
        }
    }
}
