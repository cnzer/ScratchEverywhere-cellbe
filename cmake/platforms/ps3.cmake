set(SE_DEFAULT_OUTPUT_NAME "scratch-ps3")

set(SE_RENDERER_VALID_OPTIONS "sdl2")
set(SE_WINDOWING_VALID_OPTIONS "sdl2")
set(SE_AUDIO_ENGINE_VALID_OPTIONS "sdl2")
set(SE_DEPS_VALID_OPTIONS "fallback" "system")

set(SE_CACHING_DEFAULT ON)
set(SE_BUNDLE_DEFAULT ON)

set(SE_ALLOW_BUNDLE ON)
set(SE_ALLOW_CLOUDVARS OFF)
set(SE_ALLOW_DOWNLOAD OFF)

set(SE_HAS_THREADS ON)

set(SE_HAS_TOUCH FALSE)
set(SE_HAS_MOUSE FALSE)
set(SE_HAS_KEYBOARD FALSE)
set(SE_HAS_CONTROLLER TRUE)

set(SE_PLATFORM_DEFINITIONS "__PS3__")
set(SE_PLATFORM "ps3")

# PS3 toolchain file
set(PS3_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cmake/platforms/ps3.toolchain.cmake")

# PSL1GHT SDK paths
# Expects PS3DEV and PSL1GHT environment variables to be set
# Typically: PS3DEV=/usr/local/ps3dev, PSL1GHT=$PS3DEV

macro(package_platform)
    # PS3 uses make_self and make_package_final tools
    # This would be implemented based on PSL1GHT's packaging tools
    message(STATUS "PS3 packaging not yet implemented - would create .pkg or .self file")
endmacro()

# Add PS3-specific compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -fno-rtti")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti")

# PS3 PPU architecture flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m64")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64")