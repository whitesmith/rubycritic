#!/bin/bash
set -ev
if [ "${TRAVIS_RUBY_VERSION}" != "2.4" ]; then
  bundle exec appraisal install
fi
