#include <stdio.h>

int main(int argc, char * argv[])
{
	int result = 0;
	for(int i = 0; i < argc; ++i)
	{
		result += atoi(*(argv + i) );
	}
	printf("%d", result);
}
