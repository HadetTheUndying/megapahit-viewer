<picture>
  <source media="(prefers-color-scheme: dark)" srcset="doc/sl-logo-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="doc/sl-logo.png">
  <img alt="Second Life Logo" src="doc/sl-logo.png">
</picture>

**[Second Life][] is a free 3D virtual world where users can create, connect and chat with others from around the
world.** This repository contains a fork of the source code for the official client.

## Open Source

Second Life provides a huge variety of tools for expression, content creation, socialization and play. Its vibrancy is
only possible because of input and contributions from its residents. The client codebase has been open source since
2007 and is available under the LGPL license. The [Open Source Portal][] contains additional information about Linden
Lab's open source history and projects.

## Download

Most people use a pre-built viewer release to access Second Life. macOS, GNU/Linux and FreeBSD builds are
[published on the official website][download]. More experimental viewers, such as release candidates and
project viewers, are detailed on the same page.

### Third Party Viewer

As a third party maintained fork, which includes Apple Silicon native builds, Megapahit viewer is indexed in the [Third Party Viewer Directory][tpv].

## Build Instructions

```
$ cd viewer
$ git remote add megapahit git://megapahit.org/viewer.git
$ git fetch megapahit
$ git checkout megapahit/main
$ git switch -c megapahit
```

### macOS

```
$ mkdir -p build/universal-apple-darwin`uname -r`/packages
$ cd ~/Downloads
$ curl -OL https://github.com/secondlife/3p-curl/releases/download/v7.54.1-513145c/curl-7.54.1-513145c-darwin64-513145c.tar.zst -OL https://megapahit.net/downloads/dullahan-1.14.0.202312131437_118.7.1_g99817d2_chromium-118.0.5993.119-darwinuniversal-233471337.tar.bz2 -OL https://github.com/secondlife/3p-emoji-shortcodes/releases/download/v6.1.0.5413f58/emoji_shortcodes-6.1.0.5413f58-darwin64-5413f58.tar.zst -OL https://github.com/secondlife/3p-glh_linear/releases/download/v1.0.1-dev4-984c397/glh_linear-1.0.1-dev4-common-984c397.tar.zst -OL https://github.com/secondlife/llca/releases/download/v202402012004.0-0f5d9c3/llca-202402012004.0-common-0f5d9c3.tar.zst -L https://github.com/zeux/meshoptimizer/archive/refs/tags/v0.21.tar.gz -o meshoptimizer-0.21.tar.gz -OL https://github.com/secondlife/3p-mikktspace/releases/download/v2-e967e1b/mikktspace-1-darwin64-8756084692.tar.zst -OL https://automated-builds-secondlife-com.s3.amazonaws.com/ct2/115452/994130/nanosvg-2022.09.27-darwin64-580364.tar.bz2 -OL https://github.com/secondlife/3p-openssl/releases/download/v1.1.1q.de53f55/openssl-1.1.1q.de53f55-darwin64-de53f55.tar.zst -OL https://github.com/secondlife/3p-tinyexr/releases/download/v1.0.8-ba4bc64/tinyexr-v1.0.8-common-9373975608.tar.zst -OL https://github.com/secondlife/3p-tinygltf/releases/download/v2.5.0-1ae57fd/tinygltf-v2.5.0-common-1ae57fd.tar.zst -OL https://github.com/secondlife/3p-viewer-fonts/releases/download/v1.0.0-r1/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst -OL https://sourceforge.net/projects/xmlrpc-epi/files/xmlrpc-epi-base/0.54.2/xmlrpc-epi-0.54.2.tar.bz2
$ cd -
$ cd ..
$ tar xf ~/Downloads/meshoptimizer-0.21.tar.gz
$ cd meshoptimizer-0.21
$ mkdir -p build/universal-apple-darwin`uname -r`
$ cd build/universal-apple-darwin`uname -r`
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_OSX_ARCHITECTURES:STRING="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=12.0 -DMESHOPT_BUILD_SHARED_LIBS:BOOL=ON ../..
$ make -j`gnproc`
$ sudo make install
$ cd ../../../viewer/indra/newview
$ tar xf ~/Downloads/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst
$ cd ../../build/universal-apple-darwin`uname -r`/packages
$ tar xf ~/Downloads/curl-7.54.1-513145c-darwin64-513145c.tar.zst
$ tar xf ~/Downloads/dullahan-1.14.0.202312131437_118.7.1_g99817d2_chromium-118.0.5993.119-darwinuniversal-233471337.tar.bz2
$ tar xf ~/Downloads/emoji_shortcodes-6.1.0.5413f58-darwin64-5413f58.tar.zst
$ tar xf ~/Downloads/glh_linear-1.0.1-dev4-common-984c397.tar.zst
$ tar xf ~/Downloads/llca-202402012004.0-common-0f5d9c3.tar.zst
$ tar xf ~/Downloads/mikktspace-1-darwin64-8756084692.tar.zst
$ tar xf ~/Downloads/nanosvg-2022.09.27-darwin64-580364.tar.bz2
$ tar xf ~/Downloads/openssl-1.1.1q.de53f55-darwin64-de53f55.tar.zst
$ tar xf ~/Downloads/tinyexr-v1.0.8-common-9373975608.tar.zst
$ tar xf ~/Downloads/tinygltf-v2.5.0-common-1ae57fd.tar.zst
$ cd ..
$ export LL_BUILD="-O3 -gdwarf-2 -stdlib=libc++ -iwithsysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -std=c++17 -fPIC -DLL_RELEASE=1 -DLL_RELEASE_FOR_DOWNLOAD=1 -DNDEBUG -DPIC -DLL_DARWIN=1"
$ sudo port install cmake pkgconfig freealut +universal apr-util +universal boost +universal collada-dom +universal hunspell +universal jsoncpp +universal openjpeg +universal libsdl2 +universal uriparser +universal
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=newview/Megapahit.app/Contents -DCMAKE_OSX_ARCHITECTURES:STRING="arm64;x86_64" -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=OFF ../../indra
$ make -j`gnproc`
$ make install
$ open newview/Megapahit.app
```

### GNU/Linux

```
$ mkdir -p build/`uname -m`-linux-gnu/packages
$ cd ~/Downloads
$ curl -OL https://github.com/secondlife/3p-curl/releases/download/v7.54.1-513145c/curl-7.54.1-513145c-linux64-513145c.tar.zst -OL https://megapahit.net/downloads/dullahan-1.14.0.202401180326_118.7.1_g99817d2_chromium-118.0.5993.119-linux64-240180325.tar.bz2 -OL https://github.com/secondlife/3p-emoji-shortcodes/releases/download/v6.1.0.5413f58/emoji_shortcodes-6.1.0.5413f58-linux64-5413f58.tar.zst -OL https://github.com/secondlife/3p-glh_linear/releases/download/v1.0.1-dev4-984c397/glh_linear-1.0.1-dev4-common-984c397.tar.zst -OL https://github.com/secondlife/llca/releases/download/v202402012004.0-0f5d9c3/llca-202402012004.0-common-0f5d9c3.tar.zst -OL https://github.com/secondlife/3p-mikktspace/releases/download/v2-e967e1b/mikktspace-1-linux64-8756084692.tar.zst -OL https://github.com/secondlife/3p-openssl/releases/download/v1.1.1q.de53f55/openssl-1.1.1q.de53f55-linux64-de53f55.tar.zst -OL https://github.com/secondlife/3p-tinyexr/releases/download/v1.0.8-ba4bc64/tinyexr-v1.0.8-common-9373975608.tar.zst -OL https://github.com/secondlife/3p-tinygltf/releases/download/v2.5.0-1ae57fd/tinygltf-v2.5.0-common-1ae57fd.tar.zst -OL https://github.com/secondlife/3p-viewer-fonts/releases/download/v1.0.0-r1/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst
$ cd -
$ cd indra/newview
$ tar xf ~/Downloads/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst
$ cd ../../build/`uname -m`-linux-gnu/packages
$ tar xf ~/Downloads/curl-7.54.1-513145c-linux64-513145c.tar.zst
$ tar xf ~/Downloads/dullahan-1.14.0.202401180326_118.7.1_g99817d2_chromium-118.0.5993.119-linux64-240180325.tar.bz2
$ tar xf ~/Downloads/emoji_shortcodes-6.1.0.5413f58-linux64-5413f58.tar.zst
$ tar xf ~/Downloads/glh_linear-1.0.1-dev4-common-984c397.tar.zst
$ tar xf ~/Downloads/llca-202402012004.0-common-0f5d9c3.tar.zst
$ tar xf ~/Downloads/mikktspace-1-linux64-8756084692.tar.zst
$ tar xf ~/Downloads/openssl-1.1.1q.de53f55-linux64-de53f55.tar.zst
$ tar xf ~/Downloads/tinyexr-v1.0.8-common-9373975608.tar.zst
$ tar xf ~/Downloads/tinygltf-v2.5.0-common-1ae57fd.tar.zst
$ cd ..
$ export LL_BUILD="-O3 -std=c++17 -fPIC -DLL_LINUX=1"
```

#### Debian 12.5

```
$ cd ~/Downloads
$ curl -OL https://automated-builds-secondlife-com.s3.amazonaws.com/ct2/115397/993664/nanosvg-2022.09.27-linux-580337.tar.bz2
$ cd -
$ cd ../../build/`uname -m`-linux-gnu/packages
$ tar xf ~/Downloads/nanosvg-2022.09.27-linux-580337.tar.bz2
$ cd ..
$ sudo apt install cmake pkg-config libalut-dev libaprutil1-dev libboost-fiber-dev libboost-program-options-dev libboost-regex-dev libcollada-dom-dev libexpat1-dev libglu1-mesa-dev libgtk2.0-dev libhunspell-dev libjsoncpp-dev libmeshoptimizer-dev libnghttp2-dev libsdl2-dev liburiparser-dev libvlc-dev libvlccore-dev libvorbis-dev libxmlrpc-epi-dev libxxhash-dev
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_DEB:BOOL=ON -DCPACK_DEBIAN_PACKAGE_ARCHITECTURE:STRING=amd64 -DCPACK_DEBIAN_PACKAGE_DESCRIPTION:STRING="A fork of the Second Life viewer" -DCPACK_DEBIAN_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_DEBIAN_PACKAGE_SECTION:STRING=net -DCPACK_DEBIAN_PACKAGE_DEPENDES:STRING="libalut0, libaprutil1, libboost-fiber1.74.0 | libboost-fiber1.81.0, libboost-program-options1.74.0 | libboost-program-options1.81.0, libboost-regex1.74.0 | libboost-regex1.81.0, libboost-thread1.74.0 | libboost-thread1.81.0, libcollada-dom2.5-dp0, libexpat1, libgtk2.0-0, libglu1-mesa, libhunspell-1.7-0, libjsoncpp25, libmeshoptimizer2d (>= 0.18), libnghttp2-14, libsdl2-2.0-0, liburiparser1, libvlc5, libvorbisenc2, libvorbisfile3, libxmlrpc-epi0, vlc-plugin-base" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G DEB
$ sudo apt install megapahit-`cat newview/viewer_version.txt`-Linux.deb
$ megapahit
```

#### Ubuntu 24.04

```
$ sudo apt install cmake pkg-config libalut-dev libaprutil1-dev libboost-fiber-dev libboost-program-options-dev libboost-regex-dev libcollada-dom-dev libexpat1-dev libglu1-mesa-dev libgtk2.0-dev libhunspell-dev libjsoncpp-dev libmeshoptimizer-dev libnanosvg-dev libnghttp2-dev libsdl2-dev liburiparser-dev libvlc-dev libvlccore-dev libvorbis-dev libxmlrpc-epi-dev libxxhash-dev
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_DEB:BOOL=ON -DCPACK_DEBIAN_PACKAGE_ARCHITECTURE:STRING=amd64 -DCPACK_DEBIAN_PACKAGE_DESCRIPTION:STRING="A fork of the Second Life viewer" -DCPACK_DEBIAN_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_DEBIAN_PACKAGE_SECTION:STRING=net -DCPACK_DEBIAN_PACKAGE_DEPENDES:STRING="libalut0, libaprutil1t64, libboost-fiber1.83.0, libboost-program-options1.83.0, libboost-regex1.83.0, libboost-thread1.83.0, libcollada-dom2.5-dp0, libexpat1, libgtk2.0-0t64, libglu1-mesa, libhunspell-1.7-0, libjsoncpp25, libmeshoptimizer2d, libnghttp2-14, libsdl2-2.0-0, liburiparser1, libvlc5, libvorbisenc2, libvorbisfile3, libxmlrpc-epi0t64, vlc-plugin-base" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G DEB
$ sudo apt install megapahit-`cat newview/viewer_version.txt`-Linux.deb
$ megapahit
```

#### Fedora

```
$ cd ~/Downloads
$ curl -L https://github.com/zeux/meshoptimizer/archive/refs/tags/v0.21.tar.gz -o meshoptimizer-0.21.tar.gz
$ cd -
$ cd ..
$ tar xf ~/Downloads/meshoptimizer-0.21.tar.gz
$ cd meshoptimizer-0.21
$ mkdir -p build/`uname -m`-linux-gnu
$ cd build/`uname -m`-linux-gnu
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DMESHOPT_BUILD_SHARED_LIBS:BOOL=ON ../..
$ make -j`nproc`
$ sudo make install
$ cd ../../../viewer/build/`uname -m`-linux-gnu
$ sudo dnf install cmake gcc-c++ freealut-devel apr-util-devel boost-devel collada-dom-devel expat-devel mesa-libGLU-devel gtk2-devel hunspell-devel jsoncpp-devel libnghttp2-devel nanosvg-devel openjpeg2-devel SDL2-devel uriparser-devel vlc-devel libvorbis-devel xmlrpc-epi-devel xxhash-devel zstd
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_RPM:BOOL=ON -DCPACK_RPM_PACKAGE_SUMMARY:STRING="A fork of the Second Life viewer" -DCPACK_RPM_PACKAGE_ARCHITECTURE:STRING=`uname -m` -DCPACK_RPM_PACKAGE_LICENSE:STRING=LGPL-2.1-only -DCPACK_RPM_PACKAGE_VENDOR:STRING=Megapahit -DCPACK_RPM_PACKAGE_URL:STRING=https://megapahit.net -DCPACK_RPM_PACKAGE_DESCRIPTION:STRING="An entrance to virtual empires in only megabytes. A shelter for the metaverse refugess, especially those from less supported operating systems." -DCPACK_RPM_PACKAGE_REQUIRES:STRING="freealut, apr-util, boost-fiber, boost-program-options, boost-regex, boost-thread, collada-dom, expat, mesa-libGLU, gtk2, hunspell, jsoncpp, libnghttp2, openjpeg2, SDL2, uriparser, vlc-libs, vlc-plugins-base, libvorbis, xmlrpc-epi" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ cpack -G RPM
$ sudo rpm -i megapahit-`cat newview/viewer_version.txt`-Linux.rpm
$ megapahit
```

### FreeBSD

```
$ mkdir -p build/`uname -m`-unknown-freebsd14.1/packages
$ cd ~/Downloads
$ curl -OL https://github.com/secondlife/3p-emoji-shortcodes/releases/download/v6.1.0.5413f58/emoji_shortcodes-6.1.0.5413f58-linux64-5413f58.tar.zst -OL https://github.com/secondlife/3p-glh_linear/releases/download/v1.0.1-dev4-984c397/glh_linear-1.0.1-dev4-common-984c397.tar.zst -OL https://github.com/secondlife/llca/releases/download/v202402012004.0-0f5d9c3/llca-202402012004.0-common-0f5d9c3.tar.zst -OL https://github.com/secondlife/3p-mikktspace/releases/download/v2-e967e1b/mikktspace-1-linux64-8756084692.tar.zst -OL https://github.com/secondlife/3p-tinyexr/releases/download/v1.0.8-ba4bc64/tinyexr-v1.0.8-common-9373975608.tar.zst -OL https://github.com/secondlife/3p-tinygltf/releases/download/v2.5.0-1ae57fd/tinygltf-v2.5.0-common-1ae57fd.tar.zst -OL https://github.com/secondlife/3p-viewer-fonts/releases/download/v1.0.0-r1/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst
$ cd -
$ cd indra/newview
$ tar xf ~/Downloads/viewer_fonts-1.0.0.8512067490-common-8512067490.tar.zst
$ cd ../../build/`uname -m`-unknown-freebsd14.1/packages
$ tar xf ~/Downloads/emoji_shortcodes-6.1.0.5413f58-linux64-5413f58.tar.zst
$ tar xf ~/Downloads/glh_linear-1.0.1-dev4-common-984c397.tar.zst
$ tar xf ~/Downloads/llca-202402012004.0-common-0f5d9c3.tar.zst
$ tar xf ~/Downloads/mikktspace-1-linux64-8756084692.tar.zst
$ tar xf ~/Downloads/tinyexr-v1.0.8-common-9373975608.tar.zst
$ tar xf ~/Downloads/tinygltf-v2.5.0-common-1ae57fd.tar.zst
$ cd ..
$ setenv LL_BUILD "-O3 -std=c++17 -fPIC"
$ sudo su -
# portmaster devel/cmake devel/pkgconf audio/freealut devel/apr1 devel/collada-dom textproc/hunspell x11-toolkits/gtk20 misc/meshoptimizer graphics/nanosvg graphics/openjpeg devel/sdl20 net/uriparser multimedia/vlc audio/libvorbis net/xmlrpc-epi devel/xxhash
# exit
$ cmake -DCMAKE_BUILD_TYPE:STRING=Release -DADDRESS_SIZE:INTERNAL=64 -DUSESYSTEMLIBS:BOOL=ON -DUSE_OPENAL:BOOL=ON -DLL_TESTS:BOOL=OFF -DNDOF:BOOL=OFF -DVIEWER_CHANNEL:STRING=Megapahit -DVIEWER_BINARY_NAME:STRING=megapahit -DBUILD_SHARED_LIBS:BOOL=OFF -DINSTALL:BOOL=ON -DPACKAGE:BOOL=ON -DCPACK_PACKAGE_NAME:STRING=megapahit -DCPACK_BINARY_STGZ:BOOL=OFF -DCPACK_BINARY_TGZ:BOOL=OFF -DCPACK_BINARY_TZ:BOOL=OFF -DCPACK_BINARY_FREEBSD:BOOL=ON -DCPACK_FREEBSD_PACKAGE_COMMENT:STRING="A fork of the Second Life viewer" -DCPACK_FREEBSD_PACKAGE_DESCRIPTION:STRING="An entrance to virtual empires in only megabytes. A shelter for the metaverse refugess, especially those from less supported operating systems." -DCPACK_FREEBSD_PACKAGE_WWW:STRING=https://megapahit.net -DCPACK_FREEBSD_PACKAGE_LICENSE:STRING=LGPL21 -DCPACK_FREEBSD_PACKAGE_MAINTAINER:STRING=$USER@$HOST -DCPACK_FREEBSD_PACKAGE_ORIGIN:STRING=net/megapahit -DCPACK_FREEBSD_PACKAGE_DEPS:STRING="audio/freealut;devel/collada-dom;graphics/libGLU;textproc/hunspell;misc/meshoptimizer;www/libnghttp2;graphics/openjpeg;net/uriparser;multimedia/vlc;audio/libvorbis;net/xmlrpc-epi" ../../indra
$ cmake ../../indra
$ make -j`nproc`
$ sudo cpack -G FREEBSD
$ sudo pkg add megapahit-`cat newview/viewer_version.txt`-FreeBSD.pkg
$ sudo pkg set -yA 1 freealut apr1 collada-dom hunspell gtk20 meshoptimizer nanosvg openjpeg sdl20 uriparser vlc libvorbis xmlrpc-epi
$ megapahit
```

## Contribute

Help make Megapahit better! You can get involved with improvements by filing bugs, suggesting enhancements, submitting
pull requests and more. See the [CONTRIBUTING][] and the [open source portal][] for details.

[Second Life]: https://secondlife.com/
[download]: https://megapahit.net
[tpv]: http://wiki.secondlife.com/wiki/Third_Party_Viewer_Directory/Megapahit
[open source portal]: http://wiki.secondlife.com/wiki/Open_Source_Portal
[contributing]: https://megapahit.org/viewer.git/tree/CONTRIBUTING.md
