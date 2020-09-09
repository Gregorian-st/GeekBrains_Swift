import UIKit

// Задача 1 - Решить квадратное уравнение
// a*x^2 + b*x + c = 0
print("  Задача 1")
var a: Float = 10
var b: Float = 20
var c: Float = -5
var x: Float = 0

//  Строки для вывода уравнения
var signedA: String = String(abs(a))
if a < 0 {
    signedA = "-" + signedA
}
var signedB: String = "+ " + String(abs(b))
if b < 0 {
    signedB = "- " + String(abs(b))
}
var signedC: String = "+ " + String(abs(c))
if c < 0 {
    signedC = "- " + String(abs(c))
}
var strEq: String = "Уравнение \(signedA)*x^2 \(signedB)*x \(signedC) = 0"

// Вычисление
var d = pow(b, 2) - 4 * a * c
if d < 0 {
    print(strEq + " не имеет решений в действительных числах.")
} else if d > 0 {
    print(strEq + " имеет 2 решения:")
    x = (-b + sqrt(d)) / 2 / a
    print("x = \(x)")
    x = (-b - sqrt(d)) / 2 / a
    print("x = \(x)")
} else {
    print(strEq + " имеет 1 корень:")
    x = -b / 2 / a
    print("x = \(x)")
}
print("")

// Задача 2 - Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника
print("  Задача 2")
var sideA: Float = 15
var sideB: Float = 10

// Гипотенуза
var sideC = sqrt(pow(sideA, 2)+pow(sideB, 2))
print("Треугольник с катетами \(sideA)мм, \(sideB)мм имеет гипотенузу: \(sideC)мм")
// Периметр
var p = sideA + sideB + sideC
print("Периметр треугольника: \(p)мм")
// Площадь
var s = (sideA * sideB) / 2
print("Площадь треугольника: \(s)мм2")
print("")

// Задача 3 - Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
print("  Задача 3")
var deposit: Float = 1000
var percent: Float = 12.5
var period: UInt8 = 5

print("Сумма вклада: \(deposit) руб.")
print("Годовой процент: \(percent) %")
print("Вклад на \(period) лет")
for i in 1...period {
    deposit += (deposit * percent).rounded() / 100
    print("Сумма вклада на конец \(i) года: \((deposit * 100).rounded() / 100) руб.")
}
