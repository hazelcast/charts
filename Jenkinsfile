pipeline {
    agent {
        label "lab"
    }

    stages {
        stage('Configure Helm') {
            steps {
                sh 'export PATH=$PATH:/usr/local/bin && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash'
            }
        }        
        stage('Checkout GH Pages') {
            steps {
                dir("gh-pages") {
                    git branch: "gh-pages", changelog: false, poll: false, url: "git@github.com:hazelcast/charts.git"
                }
            }
        }

        stage('Package Helm') {
            steps {
                dir("gh-pages") {
                    script {
                        sh 'for CHART in ../stable/*; do /usr/local/bin/helm package --save=false ${CHART}; done'
                        sh "/usr/local/bin/helm repo index --url=https://hazelcast.github.com/charts/ ."
                    }
                }
            }
        }
        stage('Push changes') {
            steps {
                dir("gh-pages") {
                    script {
                        sh 'git add .'
                        sh 'git commit -m "New Chart version"'
                        sh 'git push origin gh-pages'
                    }
                }
            }

        }
    }
}
