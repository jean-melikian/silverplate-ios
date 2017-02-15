#!/bin/bash
<<<<<<< Updated upstream
if [ "${TRAVIS_BRANCH}" = "master" ]; then
  fastlane deploy
=======
set -ev
echo "Currently, you are on the ${TRAVIS_BRANCH} branch."
if [[ "${TRAVIS_BRANCH}" == "master" ]]; then
  bundle exec fastlane deploy
>>>>>>> Stashed changes
fi
