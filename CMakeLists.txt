cmake_minimum_required( VERSION 3.4.2 )

project( ci-test LANGUAGES CXX )

set( CMAKE_CXX_STANDARD 11 )

message( STATUS "Visual Studio $ENV{VisualStudioVersion} $ENV{VSYear}$ENV{VSArch}" )


macro( mktest target )
	add_executable( ${target} ${target}.cpp)
endmacro()

mktest( class_initializer )
mktest( for_auto )
mktest( for_lambda )
mktest( vector_initializer )
