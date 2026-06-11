!int = i64 // Type alias for 64-bit integer
module {
    
    // function to add two ints addint(i32, i32) -> i32
    func.func @addint(%a: !int, %b: !int) -> !int{
        %out = arith.addi %a, %b: !int
        return %out : !int
    }

    //main func
    func.func @main() -> !int{
        %1 = arith.constant 1: !int
        %2 = arith.constant 2: !int
        %result = func.call @addint(%1, %2) : (!int, !int) -> !int
        return %result : !int
    }
}

// lower with mlir-opt addint.mlir --convert-func-to-llvm --convert-arith-to-llvm -o addint_opt.mlir 
// run with mlir-runner -e main --entry-point-result=i32 addint_opt.mlir  
