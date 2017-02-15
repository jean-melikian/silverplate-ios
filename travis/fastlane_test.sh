#!/bin/bash
echo "Currently, you are on the ${TRAVIS_BRANCH} branch."
if [[ "${TRAVIS_BRANCH}" == "master" || "${TRAVIS_BRANCH}" == "develop" ]]; then
  fastlane test
fi
