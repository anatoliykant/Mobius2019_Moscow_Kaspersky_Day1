import UIKit

/// Задача 1
/// Что будет выведено в консоль в результате выполнения кода?
// Ответ: 18 ((2 * 3) * 3)

func foo(_ closure: (Int) -> Int) -> Int {
	return closure(closure(2))
}

func bar<T:BinaryInteger>(_ value: T) -> T {
	return value * 3
}

print(foo(bar))

/// Задача 2
/// Что будет выведено в консоль в результате выполнения кода?
// Ответ: Protocol; Protocol
// MARK: - Protocol

protocol Printable: AnyObject {
	func print()
}

extension Printable {
	
	func print() {
		Swift.print("Protocol")
	}
}

// MARK: - Class A

class A: Printable {
	
}

// MARK: - Class B

class B: A {
	
	func print() {
		Swift.print("I'm B")
	}
}

// MARK: - Usage

let array: [Printable] = [A(), B()]
array.forEach {
	$0.print()
}

/// Задача 3
/// Что будет выведено в консоль в результате выполнения кода?
// Ответ: 3, 4, 5, 6

func print(_ msg: Any, andReturn value: Any) -> Any {
	Swift.print(msg)
	return value
}

func assert(if condition: Bool, _ message: @autoclosure () -> String) {
	guard condition else {
		return
	}
	
	Swift.print(message())
}

assert(if: false, "\(print(1, andReturn: 2))")
Swift.print(3)

assert(if: true, "\(print(4, andReturn: 5))")
Swift.print(6)


/// Задача 4
/// Вычислить time complexity следующей функции
// Ответ: O(a + b), где a - кол-во элементов в массиве values, b - кол-во элементов в наборе otherValues

func complexAlgorithm(_ values: [Int], otherValues: Set<Int>) -> [Int] {
	var nonContainingElements: [Int] = []
	
	otherValues.forEach { otherValue in
		if !values.contains(otherValue) {
			nonContainingElements.append(otherValue)
		}
	}
	
	values.forEach { value in
		if !otherValues.contains(value) {
			nonContainingElements.insert(value, at: nonContainingElements.endIndex)
		}
	}
	
	return nonContainingElements
}

/// Задача 5
/// Что будет выведено в консоль в результате выполнения кода?
// Ответ:
// 2_true
// 3_true
// 4_Block Finished
// 1_Call Finished

func someFunctionToBeCalledOnMainThread() {
	assert(Thread.isMainThread)

	let queue = DispatchQueue.global(qos: .userInteractive)
	queue.sync {
		print("2_\(Thread.isMainThread)")

		queue.sync {
			print("3_\(Thread.isMainThread)")
		}

		print("4_Block Finished")
	}

	print("1_Call Finished")
}

DispatchQueue.main.async {
	someFunctionToBeCalledOnMainThread()
}
