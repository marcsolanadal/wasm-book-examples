(module
    (func $even_check (param $n i32) (result i32)
        local.get $n
        i32.const 2
        i32.rem_u
        i32.const 0
        i32.eq        
    )

    (func $is_two (param $n i32) (result i32)
        local.get $n
        i32.const 2
        i32.eq      
    )

    (func $multiple_check 
        (param $n i32) (param $m i32) (result i32) 

        local.get $n
        local.get $m
        i32.rem_u       ;; $n / $m
        i32.const 0     ;; if reminder is 0
        i32.eq          ;; m is multiple of n
    )

    (func (export "is_prime") (param $n i32) (result i32)      
        (local $i i32)

        (if (i32.eq (local.get $n) (i32.const 1))
        (then
            i32.const 0
            return
        ))

        (if (call $is_two (local.get $n))
        (then
            i32.const 1
            return  
        ))

        (block $not_prime
            (call $even_check (local.get $n))
            br_if $not_prime        

            (local.set $i (i32.const 1))

            (loop $prime_test_loop
                (local.tee $i (i32.add (local.get $i) (i32.const 2)))
                local.get $n 

                i32.ge_u ;; i >= n
                if 
                    i32.const 1
                    return
                end

                (call $multiple_check (local.get $n) (local.get $i))
                br_if $not_prime
                br $prime_test_loop
            )
        )
        i32.const 0
    ) 
)
