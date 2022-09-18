(module
    (import "env" "str_pos_len" (func $str_pos_len (param i32 i32)))  
    (import "env" "null_str" (func $null_str (param i32)))
    (import "env" "prefix_str" (func $prefix_str (param i32)))
    (import "env" "buffer" (memory 1))

    (data (i32.const 0) "null-terminating string\00")
    (data (i32.const 128) "another null-terminating string\00")
    (data (i32.const 256) "Know the length of this string")
    (data (i32.const 384) "Also know the length of this string")
    (data (i32.const 512) "\0fThis is Sparta!")
    (data (i32.const 640) "\1eanother length-prefixed string")

    (func $byte_copy (export "byte_copy")
        (param $source i32) (param $dest i32) (param $len i32) 
        (local $source_last_byte i32)

        local.get $source
        local.get $len
        i32.add ;; source + len
        local.set $source_last_byte 

        (loop $copy_loop (block $break
            local.get $dest
            local.get $source
            i32.load8_u ;; loads $source into the stack
            i32.store8 ;; takes the loaded byte and stores it into $dest           
                                
            local.get $dest 
            i32.const 1
            i32.add
            local.set $dest ;; adds one to $dest pointer

            local.get $source 
            i32.const 1 
            i32.add
            local.tee $source ;; adds one to $source pointer 

            local.get $source_last_byte 
            i32.eq ;; $source == $source_last_byte
            br_if $break 
            br $copy_loop
        )) ;; end copy loop
    )

    (func (export "main")
        (call $null_str (i32.const 0))
        (call $null_str (i32.const 128))
        (call $str_pos_len (i32.const 256) (i32.const 30))      
        (call $str_pos_len (i32.const 384) (i32.const 35))      
        (call $prefix_str (i32.const 512))
        (call $prefix_str (i32.const 640))
    )
)
