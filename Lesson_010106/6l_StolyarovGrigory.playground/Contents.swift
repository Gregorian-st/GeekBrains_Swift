import UIKit
// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
struct Queue<T> {
    private var items: [T] = []
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T? {
        return items.count > 0 ? items.remove(at: 0) : nil
    }
    // возвращает массив по условию
    func filterItems(condition: (Int) -> Bool) -> [T] {
        var tmpItems = [T] ()
        let cnt = items.count
        if cnt > 0 {
            for i in (0 ... cnt - 1) {
                if condition(i) {
                    tmpItems.append(items[i])
                }
            }
        }
        return tmpItems
    }
    // возвращает количество элементов по условию
    func countItems(condition: (T) -> Bool) -> Int {
        var cnt: Int = 0
        for item in items {
            if condition(item) {
                cnt += 1
            }
        }
        return cnt
    }
    subscript(item: Int) -> T? {
        return item >= 0 && item < items.count ? items[item] : nil
    }
}

// проверка очереди
var qInt = Queue<Int>()
qInt.push(10)
qInt.push(11)
qInt.push(12)
qInt.push(13)
qInt.push(14)
qInt.push(15)
qInt.push(16)
qInt.push(0)
qInt.push(0)

print(qInt)
if let i = qInt.pop() {
    print(i)
}
print(qInt)

// массив элементов массива очереди с нечётными индексами
let oddItems = qInt.filterItems{ $0 % 2 != 0}
print("Odd items of the array: \(oddItems)")

// массив элементов массива очереди с чётными индексами
let evenItems = qInt.filterItems{ $0 % 2 == 0}
print("Even items of the array: \(evenItems)")

// Число нулевых элементов массива
let zeroItemsCnt = qInt.countItems{ $0 == 0 }
print("Zero items count is \(zeroItemsCnt)")

// проверка subscript
if let i = qInt[0] {
    print("0 item is \(i)")
} else {
    print("0 item is nil")
}
if let i = qInt[50] {
    print("50 item is \(i)")
} else {
    print("50 item is nil")
}
