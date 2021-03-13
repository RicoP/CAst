#include <stdio.h>

typedef union vector3_t {
	struct { float x,y,z; };
	float v[3];
} vector3;

struct S {
	int foo;
};

//C11 test

inline int maxi(int a, int b)       { return a > b ? a : b; }
inline float maxf(float a, float b)   { return a > b ? a : b; }
inline double maxd(double a, double b) { return a > b ? a : b; }

#define max(a,b) _Generic((a), int: maxi, \
                              float: maxf, \
                              double: maxd)(a,b)

int main()
{
	struct S s;
	s.foo = 44;
    printf("Hello World %d  \n", s.foo);
    printf("%s %s \n", __DATE__, __TIME__);
    printf("%s:%d \n", __FILE__, __LINE__);

    printf("%f \n", max(314.0f, 123.456f));

    vector3 v = { .x = 1, .y = 2, .z = 3 };
    printf("%f %f %f \n", v.x, v.y, v.z);


    //struct vector3_t v2 = { .x = 1, .y = 1, .z = 1 };
    //printf("%f %f %f \n", v2.x, v2.y, v2.z);

    return 0;
}
