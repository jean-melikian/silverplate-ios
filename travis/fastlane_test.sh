#!/bin/bash
set -ev
echo "Currently, you are on the ${TRAVIS_BRANCH} branch."
if [[ "${TRAVIS_BRANCH}" == "master" || "${TRAVIS_BRANCH}" == "develop" ]]; then
  bundle exec fastlane test
fi
