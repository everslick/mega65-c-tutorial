#include <stdio.h>

#define _mkstr_(_s_)  #_s_
#define mkstr(_s_)    _mkstr_(_s_)

int main(int argc, char **argv) {
  printf("hello, world!\n\n");
  printf("PROGRAM=%s, VERSION=%s, TOOLCHAIN=%s\n",
    mkstr(PROGRAM), mkstr(VERSION), mkstr(TOOLCHAIN)
  );

  return (0);
}
