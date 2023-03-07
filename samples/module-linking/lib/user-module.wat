(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (param i32)))
  (import "env" "print" (func $print (type 4)))
  (import "share_ctx" "fib" (func $fib (type 3)))
  (import "share_ctx" "distance" (func $distance (type 1)))
  (import "share_ctx" "stack_pointer" (global $__stack_pointer (mut i32)))
  (import "share_ctx" "indirect_function_table" (table $fn_table 2 2 funcref))
  (import "share_ctx" "memory" (memory (;0;) 256 32768))
  (func $fib_distance (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    i32.store offset=12
    local.get 4
    local.get 1
    i32.store offset=8
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 5
    call $fib
    local.set 6
    local.get 4
    i32.load offset=8
    local.set 7
    local.get 7
    call $fib
    local.set 8
    local.get 6
    local.get 8
    call $distance
    local.set 9
    i32.const 16
    local.set 10
    local.get 4
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    local.get 9
    return)
  (func $print_global (type 0) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 0
    local.get 0
    global.get 0
    local.set 1
    local.get 1
    local.get 1
    call $print
    return)
  (func $indirect_call_table (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    i32.store offset=12
    local.get 4
    local.get 1
    i32.store offset=8
    local.get 4
    i32.load offset=8
    local.set 5
    local.get 5
    ;; call $fib
    (call_indirect $fn_table (type 3) (i32.const 0))
    local.set 6
    local.get 4
    local.get 6
    i32.store offset=4
    local.get 4
    i32.load offset=4
    local.set 7
    local.get 7
    call $print
    local.get 4
    i32.load offset=12
    local.set 8
    local.get 4
    i32.load offset=8
    local.set 9
    local.get 8
    local.get 9
    ;; call $distance
    (call_indirect $fn_table (type 1) (i32.const 1))
    local.set 10
    local.get 4
    local.get 10
    i32.store
    local.get 4
    i32.load
    local.set 11
    local.get 11
    call $print
    local.get 4
    i32.load
    local.set 12
    i32.const 16
    local.set 13
    local.get 4
    local.get 13
    i32.add
    local.set 14
    local.get 14
    global.set $__stack_pointer
    local.get 12
    return)
  (func $load (type 3) (param i32) (result i32)
    (local i32 i32)
    local.get 0
    call $print
    i32.const 0
    (i32.load (local.get 0))
    local.tee 1
    call $print
    local.get 1
    return)
  ;; (global $__stack_pointer (mut i32) (i32.const 5243920))
  (global $__stack_end (mut i32) (i32.const 0))
  (global $__stack_base (mut i32) (i32.const 5243920))
  (export "stack_pointer" (global $__stack_pointer))
  (export "load" (func $load))
  (export "fib" (func $fib))
  (export "distance" (func $distance))
  (export "fib_distance" (func $fib_distance))
  (export "indirect_call_table" (func $indirect_call_table))
  (export "memory" (memory 0)))