#!/bin/bash
set -ev
echo "Using Ruby v${TRAVIS_RUBY_VERSION}"
if [ "${TRAVIS_RUBY_VERSION}" = "3.0" ]; then
  bundle exec rake test
else
  bundle exec appraisal rake test
fi
