// Copyright (c) 2022. All rights reserved.

#include <stdlib.h>

#include "utils.h"

WASM_IMPORT("env", "print") extern void print(int num);

int fib(int num) {
  if (num == 1 || num == 0) {
    return num;
  }
  return fib(num - 1) + fib(num - 2);
}

WASM_EXPORT("distance") int distance(int x, int y) {
  return abs(x - y); 
}