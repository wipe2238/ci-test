#include <cstdlib>
#include <iostream>

#include "CMake.hpp"

#if defined(HAVE_FILESYSTEM)
 #include <filesystem>
 #if _MSC_VER == 1900 || _MSC_VER == 1800 || _MSC_VER == 1700
  namespace fs = std::tr2::sys;
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
