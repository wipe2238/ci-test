#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <vector>

int main( int argc, char** argv )
{
	std::vector<int> v = { 1, 2, 0, 7 };

	std::cout << "1337 = ";
	for_each( v.begin(), v.end(),
	[]( const int& number )
	{
		std::cout << number;
	});
	std::cout << std::endl;

	return( EXIT_SUCCESS );
}
