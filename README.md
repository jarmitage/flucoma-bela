# Flucoma x Bela
---

Warning: built and tested with experimental Bela image [v0.5.0alpha2](https://github.com/BelaPlatform/bela-image-builder/releases/tag/v0.5.0alpha2), may not work on older builds.

## Links
- https://flucoma.org
- https://discourse.flucoma.org/t/guidance-building-for-bela-platform/876/1
- https://forum.bela.io/d/2019-building-flucoma-on-bela-issue-upgrading-cmake/12

## Bela setup for building
This method assumes building on Bela and cross-compiling via `distcc` (locally via `arm-linux-gnueabihf` apparently also works, but I couldn't get it to yet).
- Bela hardware: https://bela.io
- Flucoma requires CMake >3.11 which (as of writing) is available on Bela via this image: https://github.com/BelaPlatform/bela-image-builder/releases/tag/v0.5.0alpha2
- Bela will need Internet access: https://learn.bela.io/using-bela/bela-techniques/connecting-to-wifi/
- `distcc` setup on Bela: https://gist.github.com/jarmitage/2a5dffbcfdd5532371f097e9bb80e4b0
  - Make sure to see comment thread for how to use `distcc` at the same time as sharing network over USB

# SuperCollider
---

## Install
- Download from Releases page
- Copy to Bela:
```sh
scp -r /path/to/FluidCorpusManipulation root@bela.local:/usr/share/SuperCollider/Extensions/FluidCorpusManipulation
```

## Usage
- Bela SuperCollider reference: https://learn.bela.io/using-bela/languages/supercollider/
- See examples in `/scd`

## Build
```sh
ssh root@bela.local
git clone https://github.com/supercollider/supercollider
git clone https://github.com/flucoma/flucoma-sc
cd flucoma-sc && mkdir -p build && cd build
cmake -DSC_PATH=../../supercollider-src -DCMAKE_CXX_COMPILER=distcc-clang++ -DCMAKE_C_COMPILER=distcc-clang -DCMAKE_CXX_FLAGS='-mfpu=neon -mfloat-abi=hard' -DCMAKE_C_FLAGS='-mfpu=neon -mfloat-abi=hard' -DDOCS=OFF ..
make install
cp -r ../install/FluidCorpusManipulation /usr/share/SuperCollider/Extensions/FluidCorpusManipulation
```

# Pure Data
---

## Install
- Download from Releases page
- Copy to Bela:
```sh
scp -r /path/to/FluidCorpusManipulation root@bela.local:Bela/projects/pd-externals/FluidCorpusManipulation
```

## Usage
- Bela Pure Data reference: https://learn.bela.io/using-bela/languages/pure-data/
- See examples in `/pd`

## Build
```sh
git clone https://github.com/pure-data/pure-data
git clone https://github.com/flucoma/flucoma-pd
cd flucoma-pd && mkdir -p build && cd build
cmake -DPD_PATH=../../pure-data -DCMAKE_CXX_COMPILER=distcc-clang++ -DCMAKE_C_COMPILER=distcc-clang -DCMAKE_CXX_FLAGS='-mfpu=neon -mfloat-abi=hard' -DCMAKE_C_FLAGS='-mfpu=neon -mfloat-abi=hard' -DDOCS=OFF ..
make install
cp -r ../install/FluidCorpusManipulation /Bela/projects/pd-externals/FluidCorpusManipulation
```

# C++
---

## Install
- Download from Releases page
- Copy to Bela:
```sh
scp -r /FluidCorpusManipulation root@bela.local:/usr/share/
```

## Usage
- Bela C++ reference: https://learn.bela.io/using-bela/languages/c-plus-plus/
- See examples in `/cpp`

## Build
```sh
git clone https://github.com/flucoma/flucoma-core
cd flucoma-core && mkdir -p build && cd build
cmake -DCMAKE_CXX_COMPILER=distcc-clang++ -DCMAKE_C_COMPILER=distcc-clang -DCMAKE_CXX_FLAGS='-mfpu=neon -mfloat-abi=hard' -DCMAKE_C_FLAGS='-mfpu=neon -mfloat-abi=hard' -DDOCS=OFF ..
make install
# add to path within Bela project?
```
