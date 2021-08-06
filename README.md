[![Snapshot Test and build](https://github.com/parj/SampleSpringBootApp/actions/workflows/snapshot-build.yml/badge.svg)](https://github.com/parj/SampleSpringBootApp/actions/workflows/snapshot-build.yml) [![DepShield Badge](https://depshield.sonatype.org/badges/parj/SampleSpringBootApp/depshield.svg)](https://depshield.github.io)   [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fparj%2FSampleSpringBootApp.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fparj%2FSampleSpringBootApp?ref=badge_shield)  [![Coverage Status](https://coveralls.io/repos/github/parj/SampleSpringBootApp/badge.svg?branch=master)](https://coveralls.io/github/parj/SampleSpringBootApp?branch=master)  [![codecov](https://codecov.io/gh/parj/SampleSpringBootApp/branch/master/graph/badge.svg)](https://codecov.io/gh/parj/SampleSpringBootApp) ![GitHub](https://img.shields.io/github/license/parj/SampleSpringBootApp)


# What is this

A sample spring boot application. Whilst building the application using `maven`, the project checks the CVE database for vulnerabilities (OWASP is used). In addition - travisci is used for automated builds, plus there is dependency scan is done via DepShield and FOSS status is checked by fossa.io.

# To use the kubernetes template or the ci-cd

Run `git submodule update --init --recursive`