#!/bin/bash
if [ "${TRAVIS_BRANCH}" = "master" ]; then
  fastlane deploy
fi
