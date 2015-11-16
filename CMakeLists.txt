cmake_minimum_required( VERSION 2.8 )

project( ci-test LANGUAGES CXX )

set( SRC_DIR  ${PROJECT_SOURCE_DIR} )

macro( project_set_cxx11 target )
	if( CMAKE_COMPILER_IS_GNUCXX )
		message( STATUS "${target} -std=c++11" )
		target_compile_options( ${target} PRIVATE "-std=c++11" )
	endif()
endmacro()

add_executable( ci-test ci-test.cpp )
project_set_cxx11( ci-test )
