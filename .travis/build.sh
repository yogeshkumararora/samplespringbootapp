#!/bin/bash

# Stop on error
set -e

main() {
    init
    copy_maven_settings
    setup_git
    buildArtifact
}

init() {
    exeinf "Starting..."
}

# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
tstp() {
    date +"%Y-%m-%d %H:%M:%S,%3N"
}
# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
exeinf() {
    echo "INFO " $(tstp) "$ "$@
}
# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
exeerr() {
    echo "ERROR" $(tstp) "$ "$@
}

copy_maven_settings() {
    exeinf "Copying across maven settings"
}

setup_git() {
    exeinf "Setting up git"
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
}

pushTagsAndCommit() {
    exeinf "Pushing tags"
    git push --tags
    exeinf "Pushing maven commit"
    git push -u origin release
}

#Required as mvn:release bumps tags
buildDockerImageFromLatestTag() {
    latesttag=$(git describe --tags)
    exeinf "Checking out latest tags ${latesttag}"
    git checkout ${latesttag}
    mvn package docker:build -DskipTests
}

buildArtifact() {
    echo "Branch is ${BRANCH_NAME}"

    if [[ $TRAVIS_BRANCH == "release" ]] || [[ $CIRCLE_BRANCH = "release" ]]; then
        exeinf "Release build"

        #Just do a dry run on TravisCI
        if [[ $TRAVIS_BRANCH == "release" ]]; then
            mvn -B -s .travis/settings.xml release:clean release:prepare -DdryRun=true
        fi

        #Only perform full release on circleci
        if [[ $CIRCLE_BRANCH = "release" ]] && [[ -z $CIRCLE_TAG ]]; then
            exeinf "Performing maven release"
            mvn -B -s .travis/settings.xml release:clean release:prepare release:perform -DscmCommentPrefix="[skip ci] [maven-release-plugin] "

            pushTagsAndCommit
            buildDockerImageFromLatestTag
        fi
    else
        if [[ -z $JENKINS_URL ]]; then
            exeinf "Snapshot build"
            mvn -s .travis/settings.xml deploy docker:build
        else
            exeinf "Jenkins Snapshot build"
            mvn -s .travis/settings.xml verify docker:build
        fi
    fi
}

main "$@"