// Copyright (c) 2022. All rights reserved.

/* run: node user-shared-module-linking.js  */

const { wasmLoad } = require("./lib/wasm-loader.js");

/* #################### 1. wasmLoad shared-module ##################### */
JSSharedModule = {
  env: {
    print: console.log.bind(console),
  },
};

let sharedModule = wasmLoad(
  __dirname + "/lib/shared-module.wasm",
  JSSharedModule
);

/* #################### 2. Initialize JSModule with sharedModule ##################### */
JSModule = {
  share_ctx: {
    stack_pointer: sharedModule.exports.stack_pointer,
    fib: sharedModule.exports.fib,
    distance: sharedModule.exports.distance,
    indirect_function_table: sharedModule.exports.indirect_function_table,
    memory: sharedModule.exports.memory,
  },
  env: {
    print: console.log.bind(console),
  },
};

/* ############ 3. load user-module and link with JSDepModule ############# */
let instance = wasmLoad(__dirname + "/lib/user-module.wasm", JSModule);

/* ################# 4. user-module checking ################### */
/* imports global */
console.log("\n/************* globals imported **************/");
console.log("share_ctx.stack_pointer = " + instance.exports.stack_pointer);

// 0 1 1 2 3 5 8 13 21 34 55 89
/* imports func */
console.log("\n/********* global functions imported *********/");
let fib_dist = instance.exports.fib_distance(5, 11);
console.log("fib_distance(5, 11) = " + fib_dist + " vs 84 expected");

/* import table */
console.log("\n/************** table imported ***************/");
let indirect_fn = instance.exports.indirect_call_table;
console.log("fib(11) -> fib_distance(5, 11)")
indirect_fn(5, 11);

/* import memory */
console.log("\n/************** memory exported **************/");
const val_offet = 1024;
let value = instance.exports.load(val_offet);
console.log("memory.buffer[" + val_offet + "] = " + value);
