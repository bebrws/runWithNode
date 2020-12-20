#include <string.h>
#include <stdio.h>
#include <limits.h>
#include <dlfcn.h>

#include <unistd.h>

#define MY_MAX_ARGS 100

const char *token_seperator = " ";
int main(int argc, char *argv[], char *env[]) {
    char *args[MY_MAX_ARGS];
    char **saveptr;
    char *token;
    int i = 0;

    dlopen(argv[3], RTLD_NOW);

    do { 
        token = strtok_r(argv[2], token_seperator, saveptr);
        args[i++] = token;
    } while(token && i < MY_MAX_ARGS);

    execve(argv[1], args, env);

    return 0;
}