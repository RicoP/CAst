#include <stdio.h>

struct S {
	int foo;
};

int main()
{
	struct S s;
	s.foo = 42;
    printf("Hello World %d \n", s.foo);
    return 0;
}
