# -*- cmake -*-
include(Linking)
include(Prebuilt)

include_guard()

add_library( ll::webrtc INTERFACE IMPORTED )
target_include_directories( ll::webrtc SYSTEM INTERFACE "${LIBS_PREBUILT_DIR}/include/webrtc" "${LIBS_PREBUILT_DIR}/include/webrtc/third_party/abseil-cpp")
if (CMAKE_OSX_ARCHITECTURES MATCHES arm64 OR (${LINUX_DISTRO} MATCHES fedora) OR (${LINUX_DISTRO} MATCHES opensuse-tumbleweed))
    target_compile_definitions(ll::webrtc INTERFACE CM_WEBRTC=1)
    if (${PREBUILD_TRACKING_DIR}/sentinel_installed IS_NEWER_THAN ${PREBUILD_TRACKING_DIR}/webrtc_installed OR NOT ${webrtc_installed} EQUAL 0)
        if (LINUX)
          set(WEBRTC_PLATFORM linux-x64)
        else (LINUX)
          set(WEBRTC_PLATFORM macos-arm64)
        endif (LINUX)
        if (NOT EXISTS ${CMAKE_BINARY_DIR}/libwebrtc-${WEBRTC_PLATFORM}.tar.xz)
            file(DOWNLOAD
                https://github.com/crow-misia/libwebrtc-bin/releases/download/114.5735.6.1/libwebrtc-${WEBRTC_PLATFORM}.tar.xz
                ${CMAKE_BINARY_DIR}/libwebrtc-${WEBRTC_PLATFORM}.tar.xz
                SHOW_PROGRESS
                )
        endif (NOT EXISTS ${CMAKE_BINARY_DIR}/libwebrtc-${WEBRTC_PLATFORM}.tar.xz)
        file(ARCHIVE_EXTRACT
            INPUT ${CMAKE_BINARY_DIR}/libwebrtc-${WEBRTC_PLATFORM}.tar.xz
            DESTINATION ${LIBS_PREBUILT_DIR}
            )
        file(REMOVE_RECURSE ${LIBS_PREBUILT_DIR}/include/webrtc)
        file(MAKE_DIRECTORY ${LIBS_PREBUILT_DIR}/include/webrtc)
        foreach(directory
          api
          audio
          base
          build
          buildtools
          call
          common_audio
          common_video
          examples
          logging
          media
          modules
          net
          p2p
          pc
          rtc_base
          rtc_tools
          sdk
          stats
          system_wrappers
          test
          testing
          third_party
          tools
          video
          )
          file(RENAME
            ${LIBS_PREBUILT_DIR}/include/${directory}
            ${LIBS_PREBUILT_DIR}/include/webrtc/${directory}
            )
        endforeach()
        file(RENAME
          ${LIBS_PREBUILT_DIR}/lib/libwebrtc.a
          ${LIBS_PREBUILT_DIR}/lib/release/libwebrtc.a
          )
        if (CMAKE_OSX_ARCHITECTURES MATCHES arm64)
          file(REMOVE_RECURSE ${LIBS_PREBUILT_DIR}/lib/release/WebRTC.framework)
          file(RENAME
            ${LIBS_PREBUILT_DIR}/Frameworks/WebRTC.xcframework/${WEBRTC_PLATFORM}/WebRTC.framework
            ${LIBS_PREBUILT_DIR}/lib/release/WebRTC.framework
            )
          file(REMOVE_RECURSE ${LIBS_PREBUILT_DIR}/Frameworks)
        endif (CMAKE_OSX_ARCHITECTURES MATCHES arm64)
        file(WRITE ${PREBUILD_TRACKING_DIR}/webrtc_installed "0")
    endif (${PREBUILD_TRACKING_DIR}/sentinel_installed IS_NEWER_THAN ${PREBUILD_TRACKING_DIR}/webrtc_installed OR NOT ${webrtc_installed} EQUAL 0)
elseif (NOT CMAKE_SYSTEM_NAME MATCHES FreeBSD)
use_prebuilt_binary(webrtc)
endif (CMAKE_OSX_ARCHITECTURES MATCHES arm64 OR (${LINUX_DISTRO} MATCHES fedora) OR (${LINUX_DISTRO} MATCHES opensuse-tumbleweed))

if (WINDOWS)
    target_link_libraries( ll::webrtc INTERFACE webrtc.lib )
elseif (DARWIN)
    FIND_LIBRARY(COREAUDIO_LIBRARY CoreAudio)
    FIND_LIBRARY(COREGRAPHICS_LIBRARY CoreGraphics)
    FIND_LIBRARY(AUDIOTOOLBOX_LIBRARY AudioToolbox)
    FIND_LIBRARY(COREFOUNDATION_LIBRARY CoreFoundation)
    FIND_LIBRARY(COCOA_LIBRARY Cocoa)

    target_link_libraries( ll::webrtc INTERFACE
        libwebrtc.a
        ${COREAUDIO_LIBRARY}
        ${AUDIOTOOLBOX_LIBRARY}
        ${COREGRAPHICS_LIBRARY}
        ${COREFOUNDATION_LIBRARY}
        ${COCOA_LIBRARY}
    )
elseif (LINUX)
    target_link_libraries( ll::webrtc INTERFACE libwebrtc.a X11 )
endif (WINDOWS)


