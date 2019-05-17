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

buildArtifact() {
    exeinf "Branch is ${TRAVIS_BRANCH}";
    if [[ $TRAVIS_BRANCH == "release" ]] || [[ $CIRCLE_BRANCH = "release" ]]; then
        exeinf "Release build"
        if [[ ! -z $TRAVIS_BRANCH ]]; then
            export TRAVIS_TAG="TRAVIS.$TRAVIS_BUILD_NUMBER"
            git tag "$TRAVIS_TAG" "$TRAVIS_COMMIT"
        elif [[ ! -z $CIRCLE_BRANCH ]]; then
            export CIRCLECI_TAG="CIRCLE.$CIRCLE_BUILD_NUM"
            git tag "$CIRCLECI_TAG"
        fi
        mvn -s .travis/settings.xml release:clean release:prepare -DdryRun=true
    else
        exeinf "Snapshot build"
        mvn -s .travis/settings.xml deploy
    fi
}

main "$@"