pipeline {
    agent {
        label "lab"
    }

    stages {
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
                        sh 'for CHART in ../stable/*; do helm package --save=false ${CHART}; done'
                        sh "helm repo index --url=https://hazelcast.github.com/charts/ ."
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
