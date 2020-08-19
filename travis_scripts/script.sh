#!/bin/bash
set -ev
if [ "${TRAVIS_RUBY_VERSION}" = "2.4" ]; then
  bundle exec rake test
else
  bundle exec appraisal rake test
fi
