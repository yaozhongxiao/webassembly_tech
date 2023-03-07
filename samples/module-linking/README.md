# Module Linking


## WebAssembly Building

### build c/c++ to webassembly
- build shared_module.c
  ```
  cd lib/src
  ./build.sh src/shared_module.c
  ```

- build consumer_module.c
  ```
  cd lib/src
  ./build.sh src/consumer_module.c
  ```

### build wat to webassembly
- build shared-module.wat
  ```
    cd lib
    wat2wasm shared-module.wat -o shared-module.wasm
  ```

- build user-module.wat
```
  cd lib
  wat2wasm user-module.wat -o user-module.wasm
```

## WebAssembly linking
### js + shared-module linking

```
node js-shared-module-linking.js
```
### js + user-module linking
```
node js-user-module-linking.js
```

### shared-module + user-module linking
```
node user-shared-module-linking.js
```