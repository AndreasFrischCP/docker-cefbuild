#!/bin/bash
export GN_DEFINES="is_official_build=true use_sysroot=false use_allocator=none use_allocator_shim=false symbol_level=1 is_cfi=false use_thin_lto=false proprietary_codecs=true ffmpeg_branding=\"Chrome\" use_vaapi=false"
python3 automate/automate-git.py --download-dir=./chromium_git --depot-tools-dir=./depot_tools --branch=${CHROMIUM_BRANCH} --no-debug-build --no-update --force-build --minimal-distrib-only --build-target=cefsimple --x64-build
cp chromium_git/chromium/src/cef/binary_distrib/*.tar.bz2 /build-artifacts
