@echo off

set CI=1
set APPVEYOR_BUILD_WORKER_IMAGE=Visual Studio 2013
set PLATFORM=x64
set CONFIGURATION=Release

cmake -P CMakeBuild.cmake