import UIKit

// Задача 1 - Написать функцию, которая определяет, четное число или нет
func isEven(_ num: UInt) -> Bool { return (num % 2) == 0 }

// Задача 2 - Написать функцию, которая определяет, делится ли число без остатка на 3
func isDivBy3(_ num: UInt) -> Bool { return (num % 3) == 0 }

// Задача 3 - Создать возрастающий массив из 100 чисел
var arrNums: [UInt] = Array(1...100)
print(" Массив возрастающих значений от 1 до 100:")
print(arrNums)

// Задача 4 - Удалить из этого массива все четные числа и все числа, которые не делятся на 3
var i = 0
while i < arrNums.count {
    if isEven(arrNums[i])||(!isDivBy3(arrNums[i])) {
        arrNums.remove(at: i)
    } else {
        i += 1
    }
}
print("\n Массив с исключенными значениями:")
print(arrNums)

// Задача 5 - Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов
func addFibNum(_ arr: inout [Double]) {
    arr.count < 2 ? arr.append(1) : arr.append(arr[arr.count - 1] + arr[arr.count - 2])
}
// пояснение: если определять массив чисел Фибоначчи как [UInt], то где-то на 95м элементе число Фибоначчи превышает максимальную размерность числа UInt, поэтому массив определен как [Double]
var arrFibNums: [Double] = []
while arrFibNums.count < 100 {
    addFibNum(&arrFibNums)
}
print("\n Массив чисел Фибоначчи из \(arrFibNums.count) элементов:")
print(arrFibNums)

// Задача 6 - Заполнить массив из 100 элементов различными простыми числами
func isDivBy(number num: UInt, divNumber divNum: UInt) -> Bool { return (num % divNum) == 0 }

func isSmplNum(_ arr: inout [UInt], number num: UInt) -> Bool {
    for i in arr {
        if isDivBy(number: num, divNumber: i) {
            return false
        }
    }
    return true
}

func addSmplNum(_ arr: inout [UInt]) {
    if arr.count == 0 {
        arr.append(2)
    } else {
        var num = arr[arr.count - 1] + 1
        while !isSmplNum(&arr, number: num) {
            num += 1
        }
        arr.append(num)
    }
}

var arrSmplNums: [UInt] = []
while arrSmplNums.count < 100 {
    addSmplNum(&arrSmplNums)
}
print("\n Массив простых чисел из \(arrSmplNums.count) элементов:")
print(arrSmplNums)
