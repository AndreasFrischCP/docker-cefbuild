#!/bin/bash
python3 automate/automate-git.py --download-dir=chromium_git --depot-tools-dir=depot_tools --branch=${CHROMIUM_BRANCH} --no-build --no-distrib
patch -d chromium_git/chromium/src -p1 < patches/allocator_shim_fix.patch
