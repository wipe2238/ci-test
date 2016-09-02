cmake_minimum_required( VERSION 3.4.2 )

project( ci-test LANGUAGES CXX )

set( CMAKE_CXX_STANDARD 11 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

function( add_compile_option target var flag )
	include( CheckCXXCompilerFlag )
	check_cxx_compiler_flag( ${flag} ${var} )

	if( ${var} )
		target_compile_options( ${target} PRIVATE ${flag} )
	endif()
endfunction()

function( lib_filesystem target )
	include(CheckIncludeFileCXX)

	set( CMAKE_REQUIRED_FLAGS_OLD "${CMAKE_REQUIRED_FLAGS}" )
	set( CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS} ${CMAKE_CXX11_STANDARD_COMPILE_OPTION}" )

	check_include_file_cxx( filesystem HAVE_FILESYSTEM )
	if( HAVE_FILESYSTEM )
		target_compile_definitions( ${target} PRIVATE -DHAVE_FILESYSTEM=1 )
	else()
		check_include_file_cxx( experimental/filesystem HAVE_EXPERIMENTAL_FILESYSTEM )
	endif()

	set( CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS_OLD}" )

	if( HAVE_EXPERIMENTAL_FILESYSTEM )
		target_compile_definitions( ${target} PRIVATE -DHAVE_EXPERIMENTAL_FILESYSTEM=1 )
		target_link_libraries( ${target} stdc++fs )
	endif()

endfunction()

macro( mktest target )
	add_executable( ${target} ${target}.cpp)

	if( CMAKE_COMPILER_IS_GNUCXX )
		add_compile_option( ${target} COMPILER_WALL   -Wall )
		add_compile_option( ${target} COMPILER_WERROR -Werror )
		add_compile_option( ${target} COMPILER_WEXTRA -Wextra )
	elseif( MSVC )
		add_compile_option( ${target} COMPILER_WALL   /Wall )
		add_compile_option( ${target} COMPILER_WD4515 /wd4514 ) # derp
		add_compile_option( ${target} COMPILER_WX     /WX )
	endif()
endmacro()

mktest( class_initializer )
mktest( filesystem )
mktest( for_auto )
mktest( for_lambda )
mktest( vector_initializer )

lib_filesystem( filesystem )
