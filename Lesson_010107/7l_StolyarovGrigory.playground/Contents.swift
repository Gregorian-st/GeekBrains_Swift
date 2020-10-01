import UIKit

// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

enum QueueError {
    case isEmpty
    case notFound
}

class Queue<T> {
    private var items: [T] = []
    func push(_ item: T) {
        self.items.append(item)
    }
    func pop() -> (T?, QueueError?) {
        if !self.items.isEmpty {
            return (self.items.remove(at: 0), nil)
        } else {
            return (nil, QueueError.isEmpty)
        }
    }
    // возвращает количество элементов по условию
    func countItems(condition: (T) -> Bool) -> (Int?, QueueError?) {
        var cnt: Int = 0
        for item in self.items {
            if condition(item) {
                cnt += 1
            }
        }
        if cnt > 0 {
            return (cnt, nil)
        } else {
            return (nil, QueueError.notFound)
        }
    }
}

let q = Queue<Int>()
q.push(11)
q.push(12)
q.push(13)
q.push(14)

let respond = q.countItems{ $0 < 10 }
if let i = respond.0 {
    print(i)
} else if let error = respond.1 {
    print("Ошибка: \(error)")
}

for _ in (0...4) {
    let respond = q.pop()
    if let i = respond.0 {
        print(i)
    } else if let error = respond.1 {
        print("Ошибка: \(error)")
    }
}

//  2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

enum CarError: Error {
    case gasTankIsLow
    case engineIsNotStarted
    case shifterInWrongMode
    case brakeIsOn
    case gasTankOverfill
}

enum EngineStatus {
    case stopped
    case started
}

enum ShifterStatus {
    case parking
    case rear
    case neutral
    case drive
}

enum BrakeStatus {
    case off
    case on
}

enum DriveDirection {
    case forward
    case backward
}

struct CarSpeed {
    var speed: Float
    var direction: DriveDirection
}

class Car {
    var gasTankVolume: Float
    var engineStatus: EngineStatus
    var shifterSatatus: ShifterStatus
    var brakeStatus: BrakeStatus
    var maxVolume: Float
    
    func start(direction: DriveDirection) throws -> CarSpeed {
        guard self.engineStatus == .started else {
            throw CarError.engineIsNotStarted
        }
        guard (self.shifterSatatus == .drive && direction == .forward) || (self.shifterSatatus == .rear && direction == .backward) else {
            throw CarError.shifterInWrongMode
        }
        guard self.gasTankVolume > 1 else {
            throw CarError.gasTankIsLow
        }
        guard self.brakeStatus == .off else {
            throw CarError.brakeIsOn
        }
        
        let cs = CarSpeed.init(speed: 5, direction: direction)
        return cs
    }
    
    func fillGasTank(volume: Float, price: Float) throws -> Float {
        let sumVolume = self.gasTankVolume + volume
        guard sumVolume <= self.maxVolume else {
            throw CarError.gasTankOverfill
        }
        return volume * price
    }
    
    init() {
        self.gasTankVolume = 20
        self.engineStatus = .stopped
        self.shifterSatatus = .parking
        self.brakeStatus = .on
        self.maxVolume = 65
    }
}

let car1 = Car.init()
car1.engineStatus = .started
car1.shifterSatatus = .drive
//car1.brakeStatus = .off

do {
    let carSpeed = try car1.start(direction: .forward)
    print(carSpeed)
} catch CarError.engineIsNotStarted {
    print("Engine is not started!")
} catch CarError.shifterInWrongMode {
    print("Shifter is in wrong mode!")
} catch CarError.gasTankIsLow {
    print("Low fuel!")
} catch CarError.brakeIsOn {
    print("Brake is on!")
} catch let error {
    print(error.localizedDescription)
}

do {
    let priceToPay = try car1.fillGasTank(volume: 50, price: 54.89)
    print(priceToPay)
} catch CarError.gasTankOverfill {
    print("Gas tank is going to be overfilled!")
}
