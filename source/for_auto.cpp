#include <cstdlib>
#include <iostream>
#include <vector>

int main( int, char** )
{
	std::vector<int> v;
	v.push_back( 1207 );
	for( auto n : v )
	{
		std::cout << n << std::endl;
	}

	return( EXIT_SUCCESS );
}
