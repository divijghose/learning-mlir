!int = i32
!float = f32
module{
    //function to convert int to float int_to_float(i32) -> f32
    func.func @int_to_float(%a: !int) -> !float{
        %out = arith.uitofp %a : !int to !float
        return %out : !float
    }

    func.func @main() -> !float{
        %1 = arith.constant 6 : !int
        %result = func.call @int_to_float(%1): (!int) -> !float
        return %result : !float
    }
}