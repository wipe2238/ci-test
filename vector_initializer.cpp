#include <cstdlib>
#include <iostream>
#include <vector>

int main( int argc, char** argv )
{
	std::vector<int> v = { 1, 2, 0, 7 };
	std::cout << v[0] << v[1] << v[2] << v[3] << std::endl;

	return( EXIT_SUCCESS );
}
