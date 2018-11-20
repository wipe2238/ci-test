@echo off

set CI=1
set APPVEYOR_BUILD_WORKER_IMAGE=Visual Studio 2015
set PLATFORM=x32
set CONFIGURATION=Release

cmake -P CMakeBuild.cmake
