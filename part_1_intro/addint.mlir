module{
	//Function: add_two_numbers_i(a: i32, b: i32) -> i32
	func.func @add_two_numbers_i(%a: i32, %b: i32) -> i32{
	%sum = arith.addi %a, %b : i32
	return %sum : i32
}
	func.func @main() -> i32 {
	%1 = arith.constant 2 : i32
	%2 = arith.constant 4 : i32
	%result = func.call @add_two_numbers_i(%1, %2) : (i32, i32) -> i32
	return %result : i32
}
}
