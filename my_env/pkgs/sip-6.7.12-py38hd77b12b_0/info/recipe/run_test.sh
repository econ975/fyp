#!/bin/bash

set -exou

pip check
sip-distinfo --help
sip-module --help
sip-build --help
sip-install --help
sip-sdist --help
sip-wheel --help

cd test
sip-build
