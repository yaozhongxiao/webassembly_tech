
#!/bin/bash
# Copyright 2022. All rights reserved.
set -e

SRC_FILE=$1
if [ -z "${SRC_FILE}" ];then
  echo "missing source file to built!"
  exit -1
fi

FILE_NAME=${SRC_FILE%.*}
FILE_NAME=${FILE_NAME##*/}

OPT_FLAGS="-O0 -v -g"
emcc ${OPT_FLAGS} --no-entry ${SRC_FILE} \
  -s WASM=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
  -o ${FILE_NAME}.wasm 2>&1 | tee ${FILE_NAME}.log

wasm2wat ${FILE_NAME}.wasm -o ${FILE_NAME}.wat
