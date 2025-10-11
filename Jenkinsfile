pipeline {
    agent any    
    stages {
        stage('install pkgs') { 
            steps {
                sh ''' 
               echo "install nginx application"
               sudo yum update
               sudo yum install http -y
             '''
            }
        }
        stage('configure appln') { 
            steps {
                sh ''' 
                echo "this is test stage"
                systemctl start http
                systemctl enable http
             '''
            }
        }
        stage('web-page') { 
            steps {
                echo "this is test deploymment1"
                sh ' sudo cp -r /home/ec2-user/2095_level/ /var/www/html'
            }
        }
        stage('Deployment') { 
            steps {
                echo "this is test deploymment2"
            }
        }
    }
}
