#!groovy

node {
    stage('Checkout') {
        checkout scm
        println "Branch is " + env.BRANCH_NAME
        check()
    }

    stage('Build') {
        sh 'printenv'
        withCredentials([string(credentialsId:'GPG_KEYNAME', variable: 'GPG_KEYNAME'), 
                         string(credentialsId:'GPG_PASSPHRASE', variable: 'GPG_PASSPHRASE'),
                         string(credentialsId:'OSS_PASSWORD', variable: 'OSS_PASSWORD')]) {
            sh '.travis/build.sh'
        }
    }

}

def check() {
    result = sh (script: "git log -1 | grep '\\[maven-release-plugin\\]'", returnStatus: true) 
    if (result == 0) {
        env.CI_SKIP = "true"
        ansiColor('xterm') {
            printf "[maven-release-plugin] found in git commit message. Aborting!"
        }
        currentBuild.result = 'ABORTED'
        error("'[maven-release-plugin] found in git commit message. Aborting!")
    }
} 
