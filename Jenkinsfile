pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    // Install the dependencies defined in requirements.txt
                    sh "pip install --no-cache-dir -r requirements.txt"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a unique tag based on the build number
                    def imageTag = "image1:${env.BUILD_NUMBER}"
                    env.IMAGE_TAG = imageTag
                    sh "docker build -t ${imageTag} ."
                }
            }
        }
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    def containerName = "cal-cont"
                    env.CONTAINER_NAME = containerName
                    // Stop and remove the existing container if it exists
                    sh """
                    docker ps -q --filter "name=${containerName}" | grep -q . && docker stop ${containerName} || true
                    docker ps -aq --filter "name=${containerName}" | grep -q . && docker rm ${containerName} || true
                    """
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the newly built Docker image, binding port 8000 of the container to port 80 on the host
                    sh "docker run -d -p 5000:5000 --name ${env.CONTAINER_NAME} ${env.IMAGE_TAG}"
                }
            }
        }
    }
}
