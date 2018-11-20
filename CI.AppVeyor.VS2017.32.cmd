@echo off

set CI=1
set APPVEYOR_BUILD_WORKER_IMAGE=Visual Studio 2017
set PLATFORM=x32

cmake -P CMakeBuild.cmake
