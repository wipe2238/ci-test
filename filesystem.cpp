#include <cstdlib>
#include <iostream>

#if defined(HAVE_FILESYSTEM)
 #include <filesystem>
 namespace fs = std::filesystem;
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
