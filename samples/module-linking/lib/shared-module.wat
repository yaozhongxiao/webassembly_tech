(module
  (type (;0;) (func (param i32) (result i32)))
  (type (;1;) (func (result i32)))
  (type (;2;) (func))
  (type (;3;) (func (param i32)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (import "env" "print" (func $print (type 3)))
  (func $fib (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store offset=8
    local.get 3
    i32.load offset=8
    local.set 4
    i32.const 1
    local.set 5
    local.get 4
    local.set 6
    local.get 5
    local.set 7
    local.get 6
    local.get 7
    i32.eq
    local.set 8
    i32.const 1
    local.set 9
    local.get 8
    local.get 9
    i32.and
    local.set 10
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 10
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=8
          local.set 11
          local.get 11
          br_if 1 (;@2;)
        end
        local.get 3
        i32.load offset=8
        local.set 12
        local.get 3
        local.get 12
        i32.store offset=12
        br 1 (;@1;)
      end
      local.get 3
      i32.load offset=8
      local.set 13
      i32.const 1
      local.set 14
      local.get 13
      local.get 14
      i32.sub
      local.set 15
      local.get 15
      call $fib
      local.set 16
      local.get 3
      i32.load offset=8
      local.set 17
      i32.const 2
      local.set 18
      local.get 17
      local.get 18
      i32.sub
      local.set 19
      local.get 19
      call $fib
      local.set 20
      local.get 16
      local.get 20
      i32.add
      local.set 21
      local.get 3
      local.get 21
      i32.store offset=12
    end
    local.get 3
    i32.load offset=12
    local.set 22
    i32.const 16
    local.set 23
    local.get 3
    local.get 23
    i32.add
    local.set 24
    local.get 24
    global.set $__stack_pointer
    local.get 22
    return)
  (func $distance (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    call $print
    local.get 4
    i32.load offset=8
    local.set 6
    local.get 6
    call $print
    local.get 4
    i32.load offset=12
    local.set 7
    local.get 4
    i32.load offset=8
    local.set 8
    local.get 7
    local.get 8
    i32.sub
    local.set 9
    local.get 9
    call $abs
    local.set 10
    i32.const 16
    local.set 11
    local.get 4
    local.get 11
    i32.add
    local.set 12
    local.get 12
    global.set $__stack_pointer
    local.get 10
    return)
  (func $abs (type 0) (param i32) (result i32)
    (local i32)
    local.get 0
    local.get 0
    i32.const 31
    i32.shr_s
    local.tee 1
    i32.add
    local.get 1
    i32.xor)
  (table (;0;) 2 2 funcref)
  (memory (;0;) 256 32768)
  (global $__stack_pointer (mut i32) (i32.const 5243920))
  (global $__stack_end (mut i32) (i32.const 0))
  (global $__stack_base (mut i32) (i32.const 5243920))
  (export "stack_pointer" (global $__stack_pointer))
  (export "fib" (func $fib))
  (export "distance" (func $distance))
  (export "indirect_function_table" (table 0))
  (export "memory" (memory 0))
  (elem (;0;) (i32.const 0) func $fib $distance)
  (data $.data (i32.const 1024) "\af\be\ad\de"))
