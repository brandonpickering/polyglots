#include <stdio.h>

/* "Backward compatible" */

int main(void) {
  if (2//**/2
      == 1)
    printf("Compiled with C90\n");
  else
    printf("Compiled with C99\n");
  return 0;
}
