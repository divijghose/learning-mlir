module{
    // func to subtract two floats subtractfloats(a: f32, b: f32) -> f32
    func.func @subtractfloats(%a: f32, %b: f32) -> f32{
        %out = arith.subf %a, %b : f32
        return %out : f32
    }

    func.func @main() -> f32{
        %1 = arith.constant 5.0 : f32
        %2 = arith.constant 3.2 : f32
        %result = func.call @subtractfloats(%1, %2): (f32, f32) -> f32
        return %result : f32
    }
}

// lower with mlir-opt subtractfloat.mlir --convert-func-to-llvm --convert-arith-to-llvm -o subtractfloat_opt.mlir
// run with mlir-runner -e main subtractfloat_opt.mlir
