set(NACL 1)


set(PLATFORM_NAME	          "NaCl")				     
set(PLATFORM_C_COMPILER     "clang")				      
set(PLATFORM_CXX_COMPILER   "clang++")			       
set(PLATFORM_ARCH           "x86_64-nacl")			
set(PLATFORM_EXE_SUFFIX     ".nexe")				    
set(PLATFORM_SDK_ROOT       "$ENV{NACL_SDK_ROOT}")
set(PLATFORM_SDK_INC_DIR    "${PLATFORM_SDK_ROOT}/include")
set(PLATFORM_SDK_LIB_DIR    "${PLATFORM_SDK_ROOT}/lib/clang-newlib_x86_64/Release")
set(PLATFORM_NACLPORT_DIR   "${PLATFORM_SDK_ROOT}/toolchain/linux_pnacl/${PLATFORM_ARCH}")
set(PLATFORM_TOOLCHAIN_DIR  "${PLATFORM_SDK_ROOT}/toolchain/linux_pnacl")

set(CMAKE_SYSTEM_NAME       "Linux")
set(CMAKE_SYSTEM_PROCESSOR  "${PLATFORM_ARCH}")
set(CMAKE_FIND_ROOT_PATH 	  "${PLATFORM_TOOLCHAIN_DIR}" "${PLATFORM_NACLPORT_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
set(CMAKE_C_COMPILER        "${PLATFORM_TOOLCHAIN_DIR}/bin/${PLATFORM_ARCH}-${PLATFORM_C_COMPILER}")
set(CMAKE_CXX_COMPILER      "${PLATFORM_TOOLCHAIN_DIR}/bin/${PLATFORM_ARCH}-${PLATFORM_CXX_COMPILER}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# SDK include and link directories
include_directories(${PLATFORM_SDK_INC_DIR})

# Freetype: Default detection script does not work correctly as freetype include dir ends with the version number ("2")
# Force include directory
set(FREETYPE_INCLUDE_DIRS	${PLATFORM_NACLPORT_DIR}/usr/include/freetype2)

# OpenGL: Regal library is used as OpenGL wrapper on top of OpenGL ES 2
# Force include directory and usage of specific libraries
set(OPENGL_INCLUDE_DIR 		${PLATFORM_NACLPORT_DIR}/usr/include)
set(OPENGL_gl_LIBRARY    	${PLATFORM_NACLPORT_DIR}/usr/lib/libRegal.a)
set(OPENGL_LIBRARIES	    ${PLATFORM_NACLPORT_DIR}/usr/lib/libRegal.a ${PLATFORM_NACLPORT_DIR}/usr/lib/libglslopt.a) # this is required too

# GLM: For convenience, GLM library is stored as git submodule of the current project
# Force include directory
set(GLM_ROOT_DIR          glm)

# PPAPI libraries
#set(PPAPI_SIMPLE_LIBRARY  "-Wl,-undefined=PSUserMainGet" "${PLATFORM_SDK_LIB_DIR}/libppapi_simple.a")
set(PPAPI_SIMPLE_LIBRARY  "${PLATFORM_SDK_LIB_DIR}/libppapi_simple.a")
#set(PPAPI_SIMPLE_LIBRARY  "${PLATFORM_SDK_LIB_DIR}/libppapi_simple_real.a")
set(NACL_IO_LIBRARY       "${PLATFORM_SDK_LIB_DIR}/libnacl_io.a")
set(PPAPI_GLES2_LIBRARY   "${PLATFORM_SDK_LIB_DIR}/libppapi_gles2.a")
set(PPAPI_CPP_LIBRARY     "${PLATFORM_SDK_LIB_DIR}/libppapi_cpp.a")
set(PPAPI_LIBRARY         "-lppapi")

macro(nacl_strip target)
  add_custom_command(TARGET ${target} POST_BUILD
    COMMENT "Stripping ${target} to ${target}_${CMAKE_SYSTEM_PROCESSOR}${PLATFORM_EXE_SUFFIX}"
    COMMAND "cp" "$<TARGET_FILE:${target}>" "$<TARGET_FILE:${target}>_${CMAKE_SYSTEM_PROCESSOR}_unstripped${PLATFORM_EXE_SUFFIX}"
    COMMAND "${PLATFORM_TOOLCHAIN_DIR}/bin/${PLATFORM_ARCH}-strip" "$<TARGET_FILE:${target}>" "-o" "$<TARGET_FILE:${target}>_${CMAKE_SYSTEM_PROCESSOR}${PLATFORM_EXE_SUFFIX}")
endmacro()
