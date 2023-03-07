// Copyright (c) 2022. All rights reserved.

"use strict";

const nodeFS = require("fs");
const nodePath = require("path");

function readWasmSync(filename) {
  let ret = nodeFS.readFileSync(filename, null);
  if (!ret.buffer) {
    ret = new Uint8Array(ret);
  }
  return ret;
};

async function fetchWasm(filename) {
  let response = await fetch(filename);
  let ret = await response.arrayBuffer();
  if (!ret.buffer) {
    ret = new Uint8Array(ret);
  }
  return ret;
};

module.exports = { readWasmSync, fetchWasm };
