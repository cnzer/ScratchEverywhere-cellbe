# PS3 Toolchain file for CMake
# This toolchain file configures CMake to cross-compile for PS3 using the PSL1GHT SDK
# Requires PS3DEV and PSL1GHT to be set either as:
#   - Environment variables: PS3DEV=/usr/local/ps3dev, PSL1GHT=$PS3DEV
#   - CMake cache variables: -DPS3DEV=/usr/local/ps3dev -DPSL1GHT=/usr/local/ps3dev

# Only configure once - check if compiler is already set
if(CMAKE_C_COMPILER AND CMAKE_C_COMPILER MATCHES "powerpc64-ps3-elf")
    return()
endif()

# During try_compile, CMAKE_C_COMPILER is not set yet - just return
if(NOT CMAKE_C_COMPILER)
    return()
endif()

# Set the target system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR powerpc64)
set(CMAKE_SYSTEM_VERSION 1)

# Check for PS3DEV - first check CMake cache variable, then environment
if(DEFINED PS3DEV AND NOT "${PS3DEV}" STREQUAL "")
    # Use CMake variable
elseif(DEFINED ENV{PS3DEV} AND NOT "$ENV{PS3DEV}" STREQUAL "")
    set(PS3DEV $ENV{PS3DEV})
else()
    message(FATAL_ERROR "PS3DEV not set. Please set PS3DEV to your PS3 SDK installation path (e.g., /usr/local/ps3dev) via -DPS3DEV=... or environment variable")
endif()

# Check for PSL1GHT - first check CMake cache variable, then environment
if(DEFINED PSL1GHT AND NOT "${PSL1GHT}" STREQUAL "")
    # Use CMake variable
elseif(DEFINED ENV{PSL1GHT} AND NOT "$ENV{PSL1GHT}" STREQUAL "")
    set(PSL1GHT $ENV{PSL1GHT})
else()
    message(FATAL_ERROR "PSL1GHT not set. Please set PSL1GHT to your PSL1GHT SDK path (typically same as PS3DEV) via -DPSL1GHT=... or environment variable")
endif()

message(STATUS "PS3DEV = ${PS3DEV}")
message(STATUS "PSL1GHT = ${PSL1GHT}")

# Set the cross-compiler
set(CMAKE_C_COMPILER "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-gcc" CACHE FILEPATH "PS3 C Compiler" FORCE)
set(CMAKE_CXX_COMPILER "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-g++" CACHE FILEPATH "PS3 CXX Compiler" FORCE)
set(CMAKE_ASM_COMPILER "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-gcc" CACHE FILEPATH "PS3 ASM Compiler" FORCE)
set(CMAKE_AR "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ar" CACHE FILEPATH "PS3 AR" FORCE)
set(CMAKE_RANLIB "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ranlib" CACHE FILEPATH "PS3 RANLIB" FORCE)
set(CMAKE_STRIP "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-strip" CACHE FILEPATH "PS3 STRIP" FORCE)
set(CMAKE_OBJCOPY "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-objcopy" CACHE FILEPATH "PS3 OBJCOPY" FORCE)
set(CMAKE_OBJDUMP "${PS3DEV}/ppu/bin/powerpc64-ps3-elf-objdump" CACHE FILEPATH "PS3 OBJDUMP" FORCE)

# Set the sysroot
set(CMAKE_SYSROOT "${PSL1GHT}")

# Search paths for libraries and headers in the SDK
set(CMAKE_FIND_ROOT_PATH "${PSL1GHT}" "${PS3DEV}/ppu")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# PS3 specific compiler flags
set(PS3_C_FLAGS "-m64 -ffunction-sections -fdata-sections")
set(PS3_CXX_FLAGS "-m64 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${PS3_C_FLAGS}" CACHE STRING "PS3 C flags" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PS3_CXX_FLAGS}" CACHE STRING "PS3 CXX flags" FORCE)

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections" CACHE STRING "PS3 linker flags" FORCE)

# PKG_CONFIG setup for cross-compilation
set(ENV{PKG_CONFIG_LIBDIR} "${PSL1GHT}/lib/pkgconfig:${PS3DEV}/ppu/lib/pkgconfig")
set(ENV{PKG_CONFIG_PATH} "")

# Define PS3 platform
add_compile_definitions(__PS3__ PS3)

# Disable trying to run target executables during build
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# PS3 uses static libraries primarily
set(BUILD_SHARED_LIBS OFF)

# Disable find_package for system packages
set(CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY ON)
set(CMAKE_FIND_PACKAGE_NO_CMAKE_PACKAGE_REGISTRY ON)