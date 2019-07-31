include(vcpkg_common_functions)

if (VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "leveldb doesn't supports UWP")
endif()

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "jasper-wan/leveldb-mcpe"
    REF 1.22-mcpe
    SHA512  7c6de4b65eff213cc12aa5a0396aa75fee16eb486ab2e0f6c3c8ad92185d7d43b5a807cb2a1d6819bcfb55347b494d10a751e383917c58e1d6589f24ed3531a2
    HEAD_REF mcpe
    PATCHES
        fix_config.patch
)

file(COPY ${CURRENT_PORT_DIR}/leveldb-mcpeConfig.cmake.in DESTINATION ${SOURCE_PATH}/cmake)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS_DEBUG -DINSTALL_HEADERS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/leveldb)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/leveldb-mcpe RENAME copyright)
