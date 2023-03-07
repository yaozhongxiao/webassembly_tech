// Copyright (c) 2022. All rights reserved.

"use strict";

const { readWasmSync } = require("./read-wasm.js");
const { wasmLink } = require("./wasm-linker");

function wasmLoad(filename, depModule) {
  let bytecodes = readWasmSync(filename);
  let wasm_module = new WebAssembly.Module(bytecodes);
  let instance = wasmLink(wasm_module, depModule);
  return instance;
}

module.exports = { wasmLoad };
