node {
    stage('Checkout') {
        checkout scm
        println "Branch is " + env.BRANCH_NAME
        check()
    }

    def check() {
    result = sh (script: "git log -1 | grep '\\[maven-release-plugin\\]'", returnStatus: true) 
    if (result == 0) {
        env.CI_SKIP = "true"
        ansiColor('xterm') {
            printf "\e[31m\e[1mBold'[maven-release-plugin]' found in git commit message. Aborting!\e[0m\e[0m\n"
        }
        currentBuild.result = 'ABORTED'
        error("'[maven-release-plugin]' found in git commit message. Aborting!")
    } 
}