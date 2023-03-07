// Copyright (c) 2022. All rights reserved.

#include "utils.h"

__attribute__((used)) int deadbeaf = 0xdeadbeaf;

WASM_IMPORT("env", "print") extern void print(int num);
WASM_IMPORT("share_ctx", "fib") extern int fib(int num);
WASM_IMPORT("share_ctx", "distance") extern int distance(int x, int y);

WASM_EXPORT("fib_distance") int fib_distance(int n1, int n2) {
  return distance(fib(n1), fib(n2));
}

WASM_EXPORT("indirect_call_table") int indirect_call_table(int n1, int n2) {
  int fibn = fib(n2);
  print(fibn);

  int dist = distance(n1, n2);
  print(dist);
  return dist;
}
