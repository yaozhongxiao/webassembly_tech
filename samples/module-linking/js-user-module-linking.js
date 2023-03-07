// Copyright (c) 2022. All rights reserved.

/* run: node js-shared-module-linking.js  */

const { wasmLoad } = require("./lib/wasm-loader.js");

/* #################### 1. define the JS-Module ##################### */
/* define S.funcs */
function fib(num) {
  if (num == 1 || num == 0) {
    return num;
  }
  return fib(num - 1) + fib(num - 2);
}

function fibToImport(num) {
  let ret = fib(num);
  console.log("invoke fib(" + num + ") = " + ret);
  return ret;
}

function distance(n1, n2) {
  let ret = Math.abs(n1 - n2);
  console.log("invoke distance(" + n1 + ", " + n2 + ") = " + ret);
  return ret;
}

/* define S.table */
const fn_table = new WebAssembly.Table({
  initial: 2,
  maximum: 2,
  element: "anyfunc",
});

/*
 * set table directl will fire the TypeError
 * "TypeError: WebAssembly.Table.set(): Argument 1 is invalid for table: function-typed object must be null (if nullable) or a Wasm function object"
 * however, we can set table by export the 'imported function' after wasm instantiated
 * see < import table > below
 */
// fn_table.set(0, fibToImport);
// fn_table.set(1, distance);

/* define S.memory */
const importMemory = new WebAssembly.Memory({
  initial: 256,
  maximum: 32768,
});
const val_offet = 1024;
let i32array = new Int32Array(importMemory.buffer);
i32array[val_offet / 4] = 12321; /* -559038801 */

const sp = new WebAssembly.Global({ value: "i32", mutable: true }, 5243920);
JSModule = {
  share_ctx: {
    stack_pointer: sp,
    fib: fibToImport,
    distance: distance,
    indirect_function_table: fn_table,
    memory: importMemory
  },
  env: {
    print: console.log.bind(console),
  },
};

/* ############ 2. user-module load and link with JSDepModule ############# */
let instance = wasmLoad(__dirname + "/lib/user-module.wasm", JSModule);

/* ################# 3. user-module checking ################### */
/* imports global */
console.log("\n/************* globals imported **************/");
console.log("stack_pointer = " + instance.exports.stack_pointer);

// 0 1 1 2 3 5 8 13 21 34 55 89
/* imports func */
console.log("\n/********* global functions imported *********/");
let fib_dist = instance.exports.fib_distance(5, 11);
console.log("fib_distance(5, 11) = " + fib_dist + " vs 84 expected");

/* import table */
let indirect_fn = instance.exports.indirect_call_table;
console.log("\n/************** table imported ***************/");
fn_table.set(0, instance.exports.fib);
fn_table.set(1, instance.exports.distance);
console.log("fib(11) -> fib_distance(5, 11)")
indirect_fn(5, 11);

/* import memory */
console.log("\n/************** memory exported **************/");
let value = instance.exports.load(val_offet);
console.log("instance.exports.load(" + val_offet + ") = " + value);
