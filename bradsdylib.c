#include <stdio.h>
#include <node.h>
#include <stdlib.h>

char *node_string = "setInterval(() => { console.log('hello from node') }, 200)";

void install(void) __attribute__ ((constructor));

void install()
{
    printf("~~~hello, world! From a node dylib!!\n");
    int argc=3;
    char *argv[4] = {"node", "-e", node_string, NULL};
    int ret = node::Start(argc, argv);
    // in src/node.h : NODE_EXTERN int Start(int argc, char* argv[]);
    printf("Node returned %d\n", ret);
}

void  entrypoint(const char * data, int * stay_resident) {
// void entrypoint(const char * arg) {
    printf("In entrypoint\n");
  printf("Dylib loaded by inject. In entry point. Passed argument %s\n", data);
  //install();
}
