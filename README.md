
# Custom CEF Build with all codecs

## Update version
* Edit `--branch=<release-branch>` in **scripts/update.sh** Based on 

## Usage
* run `./build-cef.sh`
* the checkout and compilation will take take several hours

## Build Artifacts
* after a successful build process, the subdirectory `build-artifact` will contain a tarball e.g.
* `cef_binary_104.4.26+g4180781+chromium-104.0.5112.102_linux64_minimal.tar.bz2`

## Updating
* cf. to https://bitbucket.org/chromiumembedded/cef/wiki/BranchesAndBuilding.md#markdown-header-current-release-branches-supported
* for updating the version, change the following lines of the `Dockerfile`:
```
ENV CHROMIUM_VERSION 104.0.5112.81
ENV CHROMIUM_BRANCH 5112
```

## Custom cef build options
* for changing custom build options, modify `export GN_DEFINES` line in `scripts/build.sh`
