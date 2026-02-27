# Learning MLIR - Toy codes and resources
## Resources
- [Stephen Diehl's Blog](https://www.stephendiehl.com/posts/mlir_introduction/)
- [MLIR Tutorial](https://github.com/j2kun/mlir-tutorial) (not using at the moment)

## Installing MLIR on MacOS
While it can be installed with `brew`,
```shell
brew install llvm@20
```
I chose to build from source
```shell
git clone https://github.com/llvm/llvm-project
mkdir llvm-project/build
cd llvm-project/build
cmake -G Ninja ../llvm-project/llvm \
   -DLLVM_ENABLE_PROJECTS=mlir \
   -DLLVM_BUILD_EXAMPLES=ON \
   -DLLVM_TARGETS_TO_BUILD="Native;ARM;X86" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON \
   -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
   -DLLVM_CCACHE_BUILD=ON
cmake --build . --target check-mlir
cmake --build . --target install
```
To test the version after building, 
```shell
mlir-opt --version
```

## Introduction and first codes
