#include <algorithm>
#include <iostream>
#include <vector>

int main( int argc, char** argv )
{
	std::vector<int> v;
	v.push_back( 1207 );
	for_each( v.begin(), v.end(),
	[]( const int& n )
	{
		std::cout << n << std::endl;
	});
}
