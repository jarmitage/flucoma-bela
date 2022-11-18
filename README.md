# Flucoma x Bela

- https://discourse.flucoma.org/t/guidance-building-for-bela-platform/876/1
- https://forum.bela.io/d/2019-building-flucoma-on-bela-issue-upgrading-cmake/12

# Bela setup for building
- Bela hardware: https://bela.io
- Flucoma requires CMake >3.11 which (as of writing) is available on Bela via this image: https://github.com/BelaPlatform/bela-image-builder/releases/tag/v0.5.0alpha2
- Bela will need Internet access: https://learn.bela.io/using-bela/bela-techniques/connecting-to-wifi/
- `distcc` setup on Bela: https://gist.github.com/jarmitage/2a5dffbcfdd5532371f097e9bb80e4b0
  - Make sure to see comment thread for how to use `distcc` at the same time as sharing network over USB

# SuperCollider

## Build
This method assumes building on Bela and cross-compiling via `distcc`. 
Locally via `arm-linux-gnueabihf` apparently also works, but I couldn't get it to yet.
In theory it should be as simple as (replacing `</path/to/supercollider-src>` `<branchname>`):

```sh
ssh root@bela.local
git clone git@github.com:supercollider/supercollider.git
git clone git@github.com:flucoma/flucoma-sc.git
cd flucoma-sc && mkdir -p build && cd build
cmake -DSC_PATH=</path/to/supercollider-src> -DCMAKE_CXX_COMPILER=distcc-clang++ -DCMAKE_C_COMPILER=distcc-clang -DCMAKE_CXX_FLAGS='-mfpu=neon -mfloat-abi=hard' -DCMAKE_C_FLAGS='-mfpu=neon -mfloat-abi=hard' -DFLUID_BRANCH=<branchname> ..
make install
cp -r /path/to/flucoma-sc/release-packaging/FluidCorpusManipulation /usr/share/SuperCollider/Extensions/FluidCorpusManipulation
```

<!-- - Commented out the Transient objects, removed the include of ConvolutionTools in SineExtraction. -->

## Install
- Download release (GH pages coming eventually) https://www.dropbox.com/s/69cws5sd30ji5bu/FluidCorpusManipulationBela20220721.zip
- Copy to Bela:
```sh
scp -r /path/to/FluidCorpusManipulation root@bela.local:/usr/share/SuperCollider/Extensions/FluidCorpusManipulation
```

## Usage
- Bela SuperCollider reference: https://learn.bela.io/using-bela/languages/supercollider/
- See examples in `/scd`

# Pure Data

...

# C++

...
