// Copyright (c) 2022. All rights reserved.

#ifndef UTILS_H_
#define UTILS_H_

#define WASM_EXPORT(name) __attribute__((export_name(name)))
#define WASM_IMPORT(mod, name) \
  __attribute__((import_module(mod), import_name(name)))

#endif // UTILS_H_
