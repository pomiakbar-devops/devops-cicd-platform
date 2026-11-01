
pipeline {
    agent {
        label 'ubuntu'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code from GitHub'
                checkout scm
            }
        }

        stage('Verify Python') {
            steps {
                sh '''
                    echo "Checking Python version"
                    python3 --version

                    echo "Checking pip version"
                    python3 -m pip --version
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv .ci-venv
                    .ci-venv/bin/python -m pip install --upgrade pip
                    .ci-venv/bin/python -m pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    .ci-venv/bin/python -m pytest -v
                '''
            }
        }
    }

    post {
        always {
            echo 'CI pipeline execution completed'
        }

        success {
            echo 'All stages completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
