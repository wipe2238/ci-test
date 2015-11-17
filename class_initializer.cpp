#include <cstdlib>
#include <iostream>

struct CL
{
	int c = 1207;
};

int main( int argc, char** argv )
{
	CL C;
	std::cout << C.c << std::endl;

	return( EXIT_SUCCESS );
}
