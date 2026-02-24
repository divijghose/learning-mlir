module {
	// Function: mult_two_numbers_i(a: i32, b: i32) -> i32
	func.func @mult_two_numbers_i(%a: i32, %b: i32) -> i32{
	%mult = arith.muli %a, %b : i32
	return %mult : i32
}
	func.func @main() -> i32{
	%1 = arith.constant 4 : i32
	%2 = arith.constant 6 : i32
	%result = func.call @mult_two_numbers_i(%1, %2) : (i32, i32) -> i32
	return %result : i32
}
}
