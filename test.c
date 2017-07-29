#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <pthread.h>
#include "ssl/ssl.h"

int main(int argc, char** argv){
    void *fHandle;
    (void)argc;
    int (*func)(int, int);
    char* p;

    int conv1 = strtol(argv[1], &p, 10), conv2 = strtol(argv[2], &p, 10);
//    fHandle = dlopen("./libexam1.so", RTLD_LAZY);
    fHandle = dlopen("./testso.so", RTLD_LAZY);

    if (!fHandle) {
        printf ("%s\n", dlerror());
    }

    func = (int(*)(int, int))dlsym(fHandle,"foo");
    if (!func){
        printf ("%s\n", dlerror());
    }
    printf("result: %d\n", func(conv1,conv2));

//    exit(1);
//    dlerror();
    return 0;
}
