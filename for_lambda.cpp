#include <iostream>
#include <vector>

int main( int argc, char** argv )
{
	std::vector<int> v;
	v.push_back( 1207 );
	for( auto n : v )
	{
		std::cout << n << std::endl;
	}
}
