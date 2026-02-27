# MLIR Concepts
This content comes directly from [Stephen Diehl's Blog](https://www.stephendiehl.com/posts/mlir_introduction/)
## Conventions
- `%` prefix: Static-single assignment values (`%result`) (like an MLIR variable(?))
- `@` prefix: [[#Functions]] (`@func`)
- `^` prefix: Basic block (`^bb0`)
- `#` prefix: Attribute aliases ()
- `x` delimiter: Used in shapes and between shapes and type (`10xf32`)
- `:` and `->`: Specifies the type of an operation or value (`%result: f32`)
- `!`: Type aliases
- `()` for arguments, like `(%arg0, %arg1)`
- `{}` for regions
- `//` for comments
- `<>` to indicate type parameters, like `tensor<10xf32>`

## Modules
Top level container for MLIR operations (like a library(?))
```
module {
	//operations
}
```

## Functions
Collection of operations executed in a specific order
```mlir
func.func @my_func(%arg0: f32, %arg1: f32) -> f32{
	//operations
}
```

## Dialects
Domain-specific set of operations and types
`tensor`, `linalg`, `omp`, etc

## Operations
Basic unit of work in MLIR, with a dialect namespace
```mlir
%0 = "my_dialect.my_operation"(%arg0, %arg1): (i32, i32) -> i32
```

## Basic blocks
Execute in a linear fashion without branching

## Regions
Grouped operations

## Passes 
Transformations on MLIR dialects, like `convert-func-to-llvm`


# Writing MLIR
With an `example.mlir` file, use [[#Passes]] with `mlir-opt` to lower to llvm
```bash
mlir-opt example.mlir \
  --convert-func-to-llvm \
  --convert-math-to-llvm \
  --convert-index-to-llvm \
  --convert-scf-to-cf \
  --convert-cf-to-llvm \
  --convert-arith-to-llvm \
  --reconcile-unrealized-casts \
  -o example_opt.mlir
```

Use `mlir-runner` to directly run the `main` function from MLIR code
```bash
mlir-runner -e main -entry-point-result=i32 simple_opt.mlir
```

## Control Flow
`scf` lowers into LLVM's `cf`
For if statements,  with `%b` as the conditional variable,
```mlir
scf.if %b  {
  // true region
} else {
  // false region
}
```

For loops are implemented using `scf.for`, with an `index`
```mlir
%lb = index.constant 0
%ub = index.constant 10
%step = index.constant 1

scf.for %iv = %lb to %ub step %step {
	// loop region
}
```

This would lowered by a `convert-scf-to-cf` pass

## Math
The `arith` dialect includes the basic arithmetic operations
- Integer arithmetic: `addi`, `subi`, `muli`, `divsi` (signed), `divui` (unsigned)
- Floating point arithmetic: `addf`, etc
- Comparisons: `cmpi`, `cmpf`
- Conversions: `fptosi`
The `math` dialect has more complex math operations
- Trigonometric: `sin`, `cos`, `tan`
- Exponential: `exp`, `log`, etc
- Power: `pow`, `sqrt`
- Constants: `constant`

### Testing math codes
- [Adding two ints](addint.mlir)
- [Adding two floats](addfloat.mlir)
- [Adding int and a float](add_int_w_float.mlir)
- [Multiply two ints](multint.mlir)
- [Multiply two floats](multfloat.mlir)

To run these codes, first uses the appropriate passes to lower to llvm - 
```shell
mlir-opt example.mlir \
  --convert-func-to-llvm \
  --convert-math-to-llvm \
  --convert-arith-to-llvm \
  --reconcile-unrealized-casts \
  -o example_opt.mlir
```
Then use `mlir-runner` to run, 
```bash
mlir-runner -e main -entry-point-result=i32 simple_opt.mlir
```
(use `-entry-point-result=i32` only when the expected result is `i32`)

## Arrays
`index` is used for index computations on arrays/tensors.
Works just like math operations (`index.constant`, `index.add`, etc)