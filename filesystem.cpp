#include <cstdlib>
#include <iostream>

#include "CMake.hpp"

#if defined(HAVE_FILESYSTEM)
 #include <filesystem>
 #if defined(_MSC_VER) && _MSC_VER >= 1700
  #if _MSC_VER >= 1914 && _MSVC_LANG >= 201703L
   namespace fs = std::filesystem;
  #elif _MSC_VER >= 1910
   namespace fs = std::experimental::filesystem;
  #else
   namespace fs = std::tr2::sys;
  #endif
 #else
  namespace fs = std::filesystem;
 #endif
#elif defined(HAVE_EXPERIMENTAL_FILESYSTEM)
 #include <experimental/filesystem>
 namespace fs = std::experimental::filesystem;
#endif

int main( int, char** )
{
	if( fs::exists( fs::path( "/" )))
		std::cout << "1207" << std::endl;
	return( EXIT_SUCCESS );
}
