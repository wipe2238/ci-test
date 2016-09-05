cmake_minimum_required( VERSION 2.8.7 )

if( NOT CMAKE_ARGC )
	message( FATAL_ERROR "Usage: cmake -DCMAKELiSTS=dir/file -DCMAKEDIR=dir -P UpdateCmake.cmake" )
elseif( NOT "$ENV{CI}" )
	message( FATAL_ERROR "CI" )
endif()

if( CMAKE_HOST_UNIX )
	set( CMFILE "/tmp/cmake.sh" )
	if( CMAKE_SIZEOF_VOID_P )
		if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
			set( CMSUFFIX "Linux-x86_64.sh" )
		elseif( CMAKE_SIZEOF_VOID_P EQUAL 4 )
			set( CMSUFFIX "Linux-i386.sh" )
		else()
			message( FATAL_ERROR "Unknown architecture (CMAKE_SIZEOF_VOID_P=${CMAKE_SIZEOF_VOID_P})" )
		endif()
	# TODO: find a better way...
	elseif( $ENV{TRAVIS} )
		set( CMSUFFIX "Linux-x86_64.sh" )
	else()
		message( FATAL_ERROR "Unknown architecture" )
	endif()
elseif( CMAKE_HOST_WIN32 )
	if( $ENV{TMP} OR "$ENV{TMP}" )
		set( CMFILE "$ENV{TMP}\\cmake.zip" )
	elseif( $ENV{TEMP} OR "$ENV{TEMP}" )
		set( CMFILE "$ENV{TEMP}\\cmake.zip" )
	else()
		set( CMFILE "C:\\cmake.zip" )
	endif()
	set( CMSUFFIX "win32-x86.zip" )
else()
	message( FATAL_ERROR "Unknown host type" )
endif()

if( NOT CMAKELISTS )
	message( FATAL_ERROR "CMAKELISTS not set" )
elseif( NOT CMAKEDIR )
	message( FATAL_ERROR "CMAKEDIR not set" )
endif()

file( STRINGS ${CMAKELISTS} CMVERSION REGEX "^[\ \t]*cmake_minimum_required" )
if( CMVERSION )
	string( REGEX REPLACE ".*VERSION[ \t]+([0-9]+).*" "\\1" CMVER1 ${CMVERSION} )
	string( REGEX REPLACE ".*VERSION[ \t]+([0-9]+\\.[0-9]+).*" "\\1" CMVER2 ${CMVERSION} )
	string( REGEX REPLACE ".*VERSION[ \t]+([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1" CMVER3 ${CMVERSION} )
endif()

if( NOT CMVER1 OR CMVER1 MATCHES "cmake" )
	set( CMVER1 3 )
endif()

if( NOT CMVER2 OR CMVER2 MATCHES "cmake" )
	set( CMVER2 "${CMVER1}.0" )
endif()

if( NOT CMVER3 OR CMVER3 MATCHES "cmake" )
	set( CMVER3 "${CMVER2}.0" )
endif()

if( CMAKE_VERSION VERSION_LESS CMVER3 )
	message( STATUS "Updating CMake -- v${CMAKE_VERSION} -> ${CMVER3}" )

	file( DOWNLOAD "http://cmake.org/files/v${CMVER2}/cmake-${CMVER3}-${CMSUFFIX}" ${CMFILE} )
	if( CMAKE_HOST_UNIX )
		file( MAKE_DIRECTORY ${CMAKEDIR} )
		execute_process( COMMAND sh ${CMFILE} --prefix=${CMAKEDIR} --exclude-subdir OUTPUT_QUIET )
	elseif( CMAKE_HOST_WIN32 )
		execute_process( COMMAND 7z x ${CMFILE} -o${CMAKEDIR}.tmp OUTPUT_QUIET )
		file( RENAME "${CMAKEDIR}.tmp\\cmake-${CMVER3}-win32-x86" ${CMAKEDIR} )
	endif()
endif()
