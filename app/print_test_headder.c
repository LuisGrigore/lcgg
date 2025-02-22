#include <stdio.h>

int main(int argc, char const *argv[])
{
	if(argc != 2)
		return 0;
	printf("----------------%s----------------", argv[1]);
	return 0;
}
