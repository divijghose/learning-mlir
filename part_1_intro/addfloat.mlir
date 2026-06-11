!float = f32
module {
    //func to add two floats addfloats(f32, f32) -> f32
    func.func @addfloats(%a: !float, %b: !float) -> !float{
        %out = arith.addf %a, %b: !float
        return %out : !float
    }

    func.func @main() -> !float{
        %1 = arith.constant 1.0 : !float
        %2 = arith.constant 2.0 : !float
        %result = func.call @addfloats(%1, %2): (!float, !float) -> !float
        return %result : !float
    }
}
// lower with mlir-opt addfloat.mlir --convert-func-to-llvm --convert-arith-to-llvm -o addfloat_opt.mlir
// run with mlir-runner -e main addfloat_opt.mlir