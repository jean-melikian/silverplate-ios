#!/bin/bash
echo "Currently, you are on the ${TRAVIS_BRANCH} branch."
if [ "${TRAVIS_BRANCH}" = "master" ]; then
  fastlane deploy
fi
