#!/bin/bash
set -ev
echo "Currently, you are on the ${TRAVIS_BRANCH} branch."
if [[ "${TRAVIS_BRANCH}" == "master" ]]; then
  bundle exec fastlane deploy
fi
