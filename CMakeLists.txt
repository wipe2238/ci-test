cmake_minimum_required( VERSION 3.4.2 )
message( STATUS "CMake ${CMAKE_VERSION}" )
project( ci-test LANGUAGES CXX )

set( CMAKE_CXX_STANDARD 11 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

function( lib_filesystem target )
	include(CheckIncludeFileCXX)

	set( CMAKE_REQUIRED_FLAGS_OLD "${CMAKE_REQUIRED_FLAGS}" )
	set( CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS} ${CMAKE_CXX11_STANDARD_COMPILE_OPTION}" )

	check_include_file_cxx( filesystem HAVE_FILESYSTEM )
	if( NOT HAVE_FILESYSTEM )
		check_include_file_cxx( experimental/filesystem HAVE_EXPERIMENTAL_FILESYSTEM )
	endif()

	set( CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS_OLD}" )

	if( HAVE_EXPERIMENTAL_FILESYSTEM )
		target_link_libraries( ${target} stdc++fs )
	endif()

	if( NOT HAVE_FILESYSTEM AND NOT HAVE_EXPERIMENTAL_FILESYSTEM )
		message( STATUS "Excluded target : ${target}" )
		set_target_properties( ${target} PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1 )
	endif()
endfunction()

macro( mktest target )
	add_executable( ${target} ${target}.cpp)

	if( NOT CMAKE_BUILD_TYPE STREQUAL "Debug" )
		target_compile_definitions( ${target} PRIVATE -DNDEBUG )
	endif()
endmacro()

mktest( class_initializer )
mktest( for_auto )
mktest( for_lambda )
mktest( vector_initializer )

mktest( filesystem )
lib_filesystem( filesystem )

configure_file( ${PROJECT_SOURCE_DIR}/cmake/CMake.hpp.in ${PROJECT_SOURCE_DIR}/CMake.hpp NEWLINE_STYLE UNIX )
