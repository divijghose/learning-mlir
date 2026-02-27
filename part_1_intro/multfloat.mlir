module{
	// Function : mult_two_numbers_f(a: f32, b: f32) -> f32
	func.func @mult_two_numbers_f(%a : f32, %b : f32) -> f32 {
	%product = arith.mulf %a, %b : f32
	return %product : f32
}

	func.func @main() -> f32 {
	%1 = arith.constant 3.4 : f32
	%2 = arith.constant 6.6 : f32
	%result = func.call @mult_two_numbers_f(%1, %2) : (f32, f32) -> f32
	return %result : f32
}
}
