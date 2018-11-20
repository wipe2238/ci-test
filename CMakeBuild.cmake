cmake_minimum_required( VERSION 3.12.4 FATAL_ERROR )

if( DEFINED ENV{CI} )

	if( DEFINED ENV{APPVEYOR_BUILD_WORKER_IMAGE} )
		set( CI "AppVeyor" )
		
		if( "$ENV{PLATFORM}" STREQUAL "x32" )
		elseif( "$ENV{PLATFORM}" STREQUAL "x64" )
			set( CI_GENERATOR_SUFFIX " Win64" )
		else()
			message( FATAL_ERROR "Unknown platform : $ENV{PLATFORM}" )
		endif()

		if( DEFINED ENV{CONFIGURATION} )
			set( CI_CONFIGURATION "$ENV{CONFIGURATION}" )
		else()
			message( FATAL_ERROR "Unknown configuration" )
		endif()

		if( "$ENV{APPVEYOR_BUILD_WORKER_IMAGE}" STREQUAL "Visual Studio 2013" )
			set( CI_GENERATOR "Visual Studio 12 2013${CI_GENERATOR_SUFFIX}" )
		elseif( "$ENV{APPVEYOR_BUILD_WORKER_IMAGE}" STREQUAL "Visual Studio 2015" )
			set( CI_GENERATOR "Visual Studio 14 2015${CI_GENERATOR_SUFFIX}" )
		elseif( "$ENV{APPVEYOR_BUILD_WORKER_IMAGE}" STREQUAL "Visual Studio 2017" )
			set( CI_GENERATOR "Visual Studio 15 2017${CI_GENERATOR_SUFFIX}" )
		else()
			message( FATAL_ERROR "Unknown image : $ENV{APPVEYOR_BUILD_WORKER_IMAGE}" )
		endif()
	elseif( DEFINED ENV{TRAVIS_APP_HOST} )
		set( CI "Travis" )

		set( CI_GENERATOR "Unix Makefiles" )
	else()
		message( FATAL_ERROR "Unknown CI" )
	endif()
else()
	message( FATAL_ERROR "CI" )
endif()

message( STATUS "${CI}" )
message( STATUS "${CI_GENERATOR}" )

file( REMOVE_RECURSE build )
file( MAKE_DIRECTORY build )

unset( result )
execute_process(
	COMMAND ${CMAKE_COMMAND} -G "${CI_GENERATOR}" "${CMAKE_CURRENT_LIST_DIR}"
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/build
	RESULT_VARIABLE result
)
if( NOT result EQUAL 0 )
	message( FATAL_ERROR "Generator error" )
endif()

unset( result )
execute_process(
	COMMAND ${CMAKE_COMMAND} --build build --config ${CI_CONFIGURATION}
	RESULT_VARIABLE result
)
if( NOT result EQUAL 0 )
	message( FATAL_ERROR "Build error" )
endif()
