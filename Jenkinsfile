pipeline {
    agent any

    environment {
        WEB_ROOT = '/var/www/html'
        SRC_DIR  = '/home/ubuntu/2095_level'
    }

    stages {
        stage('Update System') {
            steps {
                echo 'Updating system packages...'
                sh '''
                    sudo apt-get update -y
                    sudo apt-get upgrade -y
                '''
            }
        }

        stage('Install NGINX') {
            steps {
                echo 'Installing NGINX...'
                sh '''
                    if ! command -v nginx > /dev/null; then
                        sudo apt-get install -y nginx
                    else
                        echo "NGINX already installed"
                    fi
                    sudo systemctl enable nginx
                    sudo systemctl start nginx
                '''
            }
        }

        stage('Deploy Web Files') {
            steps {
                echo 'Deploying index.html and dependencies...'
                sh '''
                    sudo rm -rf ${WEB_ROOT}/*
                    sudo cp -r ${SRC_DIR}/* ${WEB_ROOT}/
                    sudo chown -R www-data:www-data ${WEB_ROOT}
                    sudo chmod -R 755 ${WEB_ROOT}
                '''
            }
        }

        stage('Restart NGINX') {
            steps {
                echo 'Restarting NGINX...'
                sh 'sudo systemctl restart nginx'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! NGINX is serving your site.'
        }
        failure {
            echo '❌ Deployment failed. Check Jenkins logs for details.'
        }
    }
}