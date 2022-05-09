#!/bin/bash
set -ev
if [ "${TRAVIS_RUBY_VERSION}" != "3.0" ]; then
  bundle exec appraisal install
fi
