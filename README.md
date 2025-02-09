# UpmBuilds

This repo provides scripts and CI for building various Unity Package Manager
packages. 

## What this produces

Fundamentally, the output of this repo is files like `org.basisvr.simplebase-4.0.2.tgz`.
These are basically gzipped tar files (tar.gz files, kinda like zip files) that
the Unity Package Manager can consume as a package.

They are added to unity via the tarball import mechanism, read more 
[here](https://docs.unity3d.com/6000.0/Documentation/Manual/upm-ui-tarball.html).

## How to build

### Building with CI

CI builds these automatically on every merge to main or commit in a PR.
You can also manually dispatch the workflow by clicking "Run Workflow" 
[here](https://github.com/BasisVR/UpmBuilds/actions/workflows/ci.yaml), if you
have write access to the repo. If you don't have write access, you could fork
the repo and run it that way.

This results in a github artifact that gets uploaded to the CI run, which you can
then download.

### Building Locally
You can also clone the repo, install [just](https://just.systems), and then run 
`just all`. This is similar to a makefile and it will build all of the code.

The resulting artifacts live in the `build` directory.
