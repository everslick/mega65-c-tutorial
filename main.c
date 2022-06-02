#include <stdio.h>

#define _mkstr_(_s_)  #_s_
#define mkstr(_s_)    _mkstr_(_s_)

int main(int argc, char **argv) {
  printf("\n\nhello, world! (V%s)\n", mkstr(VERSION));

  return (0);
}
