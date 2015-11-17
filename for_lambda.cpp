#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <vector>

int main( int argc, char** argv )
{
	std::vector<int> v;
	v.push_back( 1207 );
	std::for_each( v.begin(), v.end(),
	[]( const int& n )
	{
		std::cout << n << std::endl;
	});

	return( EXIT_SUCCESS );
}
