#!/bin/sh

copy_maven_settings() {
    echo "Copying across maven settings"
    cp .travis/settings.xml $HOME/.m2/settings.xml
}

setup_git() {
    echo "Setting up git"
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
}

buildArtifact() {
    echo "Branch is ${TRAVIS_BRANCH}";
    if [[ $TRAVIS_BRANCH == "release" ]]; then
        echo "Release build"
        export TRAVIS_TAG="1.$TRAVIS_BUILD_NUMBER"
        git tag "$TRAVIS_TAG" "$TRAVIS_COMMIT"
        mvn release:clean release:prepare -DdryRun=true
    else
        echo "Snapshot build"
        mvn deploy -DskipTests
    fi
}

copy_maven_settings
setup_git
buildArtifact

