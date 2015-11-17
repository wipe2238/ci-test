cmake_minimum_required( VERSION 2.8 )

project( ci-test LANGUAGES CXX )

set( SRC_DIR  ${PROJECT_SOURCE_DIR} )

macro( mktest target )
	add_executable( ${target} ${target}.cpp)
	if( CMAKE_COMPILER_IS_GNUCXX )
		target_compile_options( ${target} PRIVATE "-std=c++11" )
	endif()
endmacro()

message( STATUS "Build type : ${CMAKE_BUILD_TYPE}" )

mktest( for_auto )
mktest( for_lambda )
mktest( vector_initializer )
