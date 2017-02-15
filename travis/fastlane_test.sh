#!/bin/bash
if [[ "${TRAVIS_BRANCH}" == "master" || "${TRAVIS_BRANCH}" == "develop" ]]; then
  fastlane test
fi
