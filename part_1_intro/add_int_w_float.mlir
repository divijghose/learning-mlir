module {
	// Function : add_int_w_float(a: i32, b: f32) -> i32
	func.func @add_int_w_float(%a: i32, %b: f32) -> i32{
	%bi = arith.fptosi %b : f32 to i32
	%sum = arith.addi %a, %bi : i32
	return %sum : i32
}
	func.func @main() -> i32 {
	%1 = arith.constant 1 : i32
	%2 = arith.constant 2.0 : f32
	%result = func.call @add_int_w_float(%1, %2) : (i32, f32) -> i32
	return %result : i32
}
}

