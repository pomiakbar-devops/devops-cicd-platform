
pipeline {
    options {
        // Prevent Jenkins from checking out the repository twice
        skipDefaultCheckout(true)
    }

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
                    echo "========== PYTHON VERSION =========="
                    python3 --version

                    echo ""
                    echo "========== PIP VERSION =========="
                    python3 -m pip --version

                    echo ""
                    echo "========== GIT VERSION =========="
                    git --version
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    echo "Creating CI virtual environment"

                    python3 -m venv .ci-venv

                    echo "Upgrading pip"

                    .ci-venv/bin/python -m pip install --upgrade pip

                    echo "Installing project dependencies"

                    .ci-venv/bin/python -m pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    echo "========== RUNNING PYTHON TESTS =========="

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
