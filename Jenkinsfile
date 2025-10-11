pipeline {
    agent any

    environment {
        WEB_ROOT = '/var/www/html'
    }

    stages {
        stage('Checkout Repository') {
            steps {
                echo '📥 Cloning GitHub repository...'
                git branch: 'main',
                    credentialsId: 'test1',
                    url: 'https://github.com/swapnibrad/3ri_batch_2.git'
            }
        }

        stage('Update & Install NGINX') {
            steps {
                echo '🧰 Updating system and installing NGINX...'
                sh '''
                    sudo apt-get update -y
                    sudo apt-get install -y nginx
                    sudo systemctl enable nginx
                    sudo systemctl start nginx
                '''
            }
        }

        stage('Deploy Website') {
            steps {
                echo '🚀 Deploying website files to /var/www/html...'
                sh '''
                    sudo rm -rf ${WEB_ROOT}/*
                    sudo cp -r * ${WEB_ROOT}/
                    sudo chown -R www-data:www-data ${WEB_ROOT}
                    sudo chmod -R 755 ${WEB_ROOT}
                '''
            }
        }

        stage('Restart NGINX') {
            steps {
                echo '🔁 Restarting NGINX...'
                sh 'sudo systemctl restart nginx'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful — site is live!'
        }
        failure {
            echo '❌ Deployment failed — check the logs.'
        }
    }
}
