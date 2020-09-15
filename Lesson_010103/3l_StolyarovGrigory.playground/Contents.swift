import UIKit

enum EngineState: String {
    case stopped = "stopped"
    case started = "started"
}

enum EngineCmd {
    case start, stop
}

enum WindowState: String {
    case closed = "closed"
    case opened = "opened"
}

enum WindowCmd {
    case close, open
}
// В задании опечатка - грузовик по-английски TruckCar, а не TrunkCar
struct TruckCar {
    var model: String
    var manufactYear: UInt16
    var bodyVolumeMax: Float
    var bodyVolumeFill: Float = 0 {
        didSet {
            if bodyVolumeFill >= self.bodyVolumeMax {
                bodyVolumeFill = self.bodyVolumeMax
            } else if bodyVolumeFill <= 0 {
                bodyVolumeFill = 0
            }
        }
    }
    var engState: EngineState = .stopped
    var driverWindow: WindowState = .closed
    var passengerWindow: WindowState = .closed
    var bodyVolumePercent: Float {
        get {
            if self.bodyVolumeMax > 0 {
                return self.bodyVolumeFill / self.bodyVolumeMax * 100
            } else {
                return 0
            }
        }
    }
    mutating func cmdToEngine(cmd: EngineCmd) {
        switch cmd {
        case .start:
            self.engState = .started
        case .stop:
            self.engState = .stopped
        }
    }
    mutating func cmdToWindow(window: String, cmd: WindowCmd) {
        switch (window.lowercased(), cmd) {
        case ("passenger", .open):
            self.passengerWindow = .opened
        case ("passenger", .close):
            self.passengerWindow = .closed
        case ("driver", .open):
            self.driverWindow = .opened
        case ("driver", .close):
            self.driverWindow = .closed
        default:
            print("There is no such window!")
        }
    }
    mutating func loadBody(volume: Float) {
        self.bodyVolumeFill += volume
    }
    mutating func unloadBody(volume: Float) {
        self.bodyVolumeFill -= volume
    }
    func getCarStatus() {
        print("\n TruckCar model is \(self.model)")
        print("Manufacturing year: \(self.manufactYear)")
        print("Max body volume: \(String(format: "%0.3f", self.bodyVolumeMax))m3")
        print("Engine is \(self.engState.rawValue)")
        print("Loaded body volume: \(String(format: "%0.3f", self.bodyVolumeFill))m3")
        print("Loading percent: \(String(format: "%0.2f", self.bodyVolumePercent))%")
        print("Driver's window is \(self.driverWindow.rawValue)")
        print("Passenger's window is \(self.passengerWindow.rawValue)")
    }
}

struct SportCar {
    var model: String
    var manufactYear: UInt16
    var trunkVolumeMax: Float
    var trunkVolumeFill: Float = 0 {
        didSet {
            if trunkVolumeFill >= self.trunkVolumeMax {
                trunkVolumeFill = self.trunkVolumeMax
            } else if trunkVolumeFill <= 0 {
                trunkVolumeFill = 0
            }
        }
    }
    var engState: EngineState = .stopped
    var driverWindow: WindowState = .closed
    var passengerWindow: WindowState = .closed
    var trunkVolumePercent: Float {
        get {
            if self.trunkVolumeMax > 0 {
                return self.trunkVolumeFill / self.trunkVolumeMax * 100
            } else {
                return 0
            }
        }
    }
    mutating func cmdToEngine(cmd: EngineCmd) {
        switch cmd {
        case .start:
            self.engState = .started
        case .stop:
            self.engState = .stopped
        }
    }
    mutating func cmdToWindow(window: String, cmd: WindowCmd) {
        switch (window.lowercased(), cmd) {
        case ("passenger", .open):
            self.passengerWindow = .opened
        case ("passenger", .close):
            self.passengerWindow = .closed
        case ("driver", .open):
            self.driverWindow = .opened
        case ("driver", .close):
            self.driverWindow = .closed
        default:
            print("There is no such window in a car!")
        }
    }
    mutating func loadTrunk(volume: Float) {
        self.trunkVolumeFill += volume
    }
    mutating func unloadTrunk(volume: Float) {
        self.trunkVolumeFill -= volume
    }
    func getCarStatus() {
        print("\n SportCar model is \(self.model)")
        print("Manufacturing year: \(self.manufactYear)")
        print("Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3")
        print("Engine is \(self.engState.rawValue)")
        print("Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3")
        print("Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%")
        print("Driver's window is \(self.driverWindow.rawValue)")
        print("Passenger's window is \(self.passengerWindow.rawValue)")
    }
}

var localTruckCar: TruckCar = TruckCar(model: "KAMAZ", manufactYear: 1976, bodyVolumeMax: 15.2)
var foreignTruckCar: TruckCar = TruckCar(model: "MAN", manufactYear: 2020, bodyVolumeMax: 18)

localTruckCar.getCarStatus()
localTruckCar.loadBody(volume: 7)
localTruckCar.cmdToWindow(window: "Driver", cmd: .open)
localTruckCar.cmdToEngine(cmd: .start)
localTruckCar.getCarStatus()

foreignTruckCar.getCarStatus()
foreignTruckCar.loadBody(volume: 20)
foreignTruckCar.unloadBody(volume: 9)
foreignTruckCar.cmdToWindow(window: "Passenger", cmd: .open)
foreignTruckCar.cmdToEngine(cmd: .start)
foreignTruckCar.getCarStatus()

var localSportCar: SportCar = SportCar(model: "MARUSSIA", manufactYear: 2013, trunkVolumeMax: 0.025)
var foreignSportCar: SportCar = SportCar(model: "PORSCHE", manufactYear: 2019, trunkVolumeMax: 0.02)

localSportCar.getCarStatus()
localSportCar.loadTrunk(volume: 0.01)
localSportCar.cmdToWindow(window: "Passenger", cmd: .open)
localSportCar.cmdToEngine(cmd: .start)
localSportCar.getCarStatus()

foreignSportCar.getCarStatus()
foreignSportCar.loadTrunk(volume: 1)
foreignSportCar.unloadTrunk(volume: 0.005)
foreignSportCar.cmdToWindow(window: "Driver", cmd: .open)
foreignSportCar.cmdToEngine(cmd: .start)
foreignSportCar.getCarStatus()
