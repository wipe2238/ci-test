// Detect operating system
#if defined (_WIN32) || defined (_WIN64)
# define IS_WINDOWS
#elif defined (__linux__)
# define IS_LINUX
#elif defined (__APPLE__)
# define IS_MACOSX
#else
# error "Unknown operating system."
#endif

// Detect compiler
#if defined (__GNUC__)
# define IS_GCC
#elif defined (_MSC_VER) && !defined (__MWERKS__)
# define IS_MSVC
#else
# error "Unknown compiler."
#endif

// Detect CPU
#if (defined (IS_MSVC) && defined (_M_IX86) ) || (defined (IS_GCC) && !defined (__LP64__) )
# warning "x32"
#elif (defined (IS_MSVC) && defined (_M_X64) ) || (defined (IS_GCC) && defined (__LP64__) )
# warning "x64"
#else
# error "Unknown CPU."
#endif

#include <cstdlib>

int main( int argc, char* argv )
{
	return( EXIT_SUCCESS );
}
