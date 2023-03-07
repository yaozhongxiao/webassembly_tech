// Copyright (c) 2022. All rights reserved.

"use strict";

function wasmLink(mainModule, importModule) {
  let instance = new WebAssembly.Instance(mainModule, importModule);
  return instance;
}

module.exports = { wasmLink };
