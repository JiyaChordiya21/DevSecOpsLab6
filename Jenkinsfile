pipeline {
    agent any

    environment {
        registry = "jiyachordiya/myapp" // Jiya's Docker Hub
        registryCredential = 'dockerhub-jiya' // Jenkins credentials ID for Jiya
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                git branch: 'main', url: 'https://github.com/JiyaChordiya21/DevSecOpsLab6.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry, '.' // Dockerfile in root
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image ${registry}"
                }
            }
        }

        stage('Deploying Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push('latest') // Push to Jiya's Docker Hub
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                sh "docker rmi ${registry}"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
