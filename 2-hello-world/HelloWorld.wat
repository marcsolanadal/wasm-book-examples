(module
  ;; expect a `print_string` fn from the embedding environment
  (import "env" "print_string" (func $print_string(param i32)))
  ;; imports a buffer from `env` and allocate one page of memory to it
  (import "env" "buffer" (memory 1))

  ;; global declarations for starting pointer to memory and length of string
  (global $start_string (import "env" "start_string") i32)
  (global $string_len i32 (i32.const 12))

  ;; writes data to location of memory
  (data (global.get $start_string) "hello world!")

  ;; exports function that calls the injected print fn passing the string length
  (func (export "helloworld")
    (call $print_string (global.get $string_len))      
  )
)
