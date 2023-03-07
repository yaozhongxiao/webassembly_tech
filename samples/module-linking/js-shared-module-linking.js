// Copyright (c) 2022. All rights reserved.

/* run: node js-shared-module-linking.js  */

/* instantiate shared-module */
const { wasmLoad } = require("./lib/wasm-loader.js");

JSModule = {
  env: {
    print: console.log.bind(console),
  },
};
let instance = wasmLoad(__dirname + "/lib/shared-module.wasm", JSModule);

function Int32ToHex(num) {
  if (num < 0) {
    return (0xffffffff + num + 1).toString(16);
  }
  return num.toString(16);
}
/* exports memory */
console.log("\n/************** memory exported **************/");
let memory = instance.exports.memory;
const i32Array = new Int32Array(memory.buffer);
console.log(
  "memory.buffer[1024] = " +
    i32Array[1024 / 4] +
    "(" +
    Int32ToHex(i32Array[1024 / 4]) +
    ")"
);

/* exports global */
let sp = instance.exports.stack_pointer;
console.log("\n/************* globals exported **************/");
console.log("stack_pointer = " + sp);

/* exports func */
let fn_fib = instance.exports.fib;
console.log("\n/********* global functions exported *********/");
console.log("fn_fib(6) = " + fn_fib(6) + " vs 8 expected");
let fn_distance = instance.exports.distance;
console.log("fn_distance(1, 9) = " + fn_distance(1, 9) + " vs 8 expected");

/* exports table */
let tbl = instance.exports.indirect_function_table;
console.log("\n/************** table exported ***************/");
// tbl[0] == fib
let fib6 = tbl.get(0)(6);
console.log("table[0](6) = " + fib6 + " vs fib(6) == 8 expected");

// tbl[1] == distance
dist8 = tbl.get(0)(1, 9);
console.log(
  "tbl[1](1, 9) = " + dist8 + " vs fn_distance(1, 9) == 8 expected\n"
);
