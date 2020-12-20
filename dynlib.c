#include <stdio.h>


__attribute__((constructor)) void constructor_function() {
    printf("constructor\n");
}