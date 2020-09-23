import UIKit

enum EngineState: String {
    case stopped
    case started
    case accelerated
}

enum EngineCmd {
    case start, stop, accelerate
}

enum WindowState: String {
    case closed
    case opened
}

enum WindowCmd {
    case close, open
}

protocol Car {
    var model: String { get set }
    var manufactYear: UInt16 { get set }
    var trunkVolumeMax: Float { get set }
    var trunkVolumeFill: Float { get set }
    var engState: EngineState { get set }
    var driverWindow: WindowState { get set }
    var passengerWindow: WindowState { get set }
    var trunkVolumePercent: Float { get }
    func cmdToEngine(cmd: EngineCmd)
}

extension Car {
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
    mutating func loadTrunk(volume: Float) {
        self.trunkVolumeFill += volume
    }
    mutating func unloadTrunk(volume: Float) {
        self.trunkVolumeFill -= volume
    }
}

class TruckCar: Car {
    var model: String
    var manufactYear: UInt16
    var trunkVolumeMax: Float
    var trunkVolumeFill: Float {
        didSet {
            if trunkVolumeFill >= self.trunkVolumeMax {
                trunkVolumeFill = self.trunkVolumeMax
            } else if trunkVolumeFill <= 0 {
                trunkVolumeFill = 0
            }
        }
    }
    var engState: EngineState
    var driverWindow: WindowState
    var passengerWindow: WindowState
    var trunkVolumePercent: Float {
        get {
            if self.trunkVolumeMax > 0 {
                return self.trunkVolumeFill / self.trunkVolumeMax * 100
            } else {
                return 0
            }
        }
    }
    var caravanConnected: Bool
    init(model: String, manufactYear: UInt16, trunkVolumeMax: Float, caravanConnected: Bool) {
        self.model = model
        self.manufactYear = manufactYear
        self.trunkVolumeMax = trunkVolumeMax
        self.trunkVolumeFill = 0
        self.engState = .stopped
        self.driverWindow = .closed
        self.passengerWindow = .closed
        self.caravanConnected = caravanConnected
    }
    func cmdToEngine(cmd: EngineCmd) {
        switch cmd {
        case .start:
            self.engState = .started
        case .stop:
            self.engState = .stopped
        case .accelerate:
            self.engState = .accelerated
        }
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        let ts: String = self.caravanConnected ? "connected" : "not connected"
        return """
            \n TruckCar model is \(self.model)
            Manufacturing year: \(self.manufactYear)
            Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3
            Caravan is \(ts)
            Engine is \(self.engState.rawValue)
            Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3
            Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%
            Driver's window is \(self.driverWindow.rawValue)
            Passenger's window is \(self.passengerWindow.rawValue)
            """
    }
}

class SportCar: Car {
    var model: String
    var manufactYear: UInt16
    var trunkVolumeMax: Float
    var trunkVolumeFill: Float {
        didSet {
            if trunkVolumeFill >= self.trunkVolumeMax {
                trunkVolumeFill = self.trunkVolumeMax
            } else if trunkVolumeFill <= 0 {
                trunkVolumeFill = 0
            }
        }
    }
    var engState: EngineState
    var driverWindow: WindowState
    var passengerWindow: WindowState
    var trunkVolumePercent: Float {
        get {
            if self.trunkVolumeMax > 0 {
                return self.trunkVolumeFill / self.trunkVolumeMax * 100
            } else {
                return 0
            }
        }
    }
    var airSpoilerInstalled: Bool
    var nitroInstalled: Bool
    var nitroActivated: Bool = false {
        didSet {
            if !nitroInstalled { self.nitroActivated = false}
        }
    }
    init(model: String, manufactYear: UInt16, trunkVolumeMax: Float, nitroInstalled: Bool, airSpoilerInstalled: Bool) {
        self.model = model
        self.manufactYear = manufactYear
        self.trunkVolumeMax = trunkVolumeMax
        self.trunkVolumeFill = 0
        self.engState = .stopped
        self.driverWindow = .closed
        self.passengerWindow = .closed
        self.nitroInstalled = nitroInstalled
        self.airSpoilerInstalled = airSpoilerInstalled
        self.nitroActivated = false
    }
    func activateNitro(activate act: Bool) {
        self.nitroActivated = act
    }
    func cmdToEngine(cmd: EngineCmd) {
        switch cmd {
        case .start:
            self.engState = .started
        case .stop:
            self.engState = .stopped
            self.activateNitro(activate: false)
        case .accelerate:
            self.engState = .accelerated
            self.activateNitro(activate: true)
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        let tsNitro: String = self.nitroInstalled ? "installed" : "not installed"
        let tsSpoiler = self.airSpoilerInstalled ? "installed" : "not installed"
        let tsNitroActivated = self.nitroActivated ? "activated" : "not activated"
        return """
            \n SportCar model is \(self.model)
            Manufacturing year: \(self.manufactYear)
            Nitrogen speed booster is \(tsNitro)
            Air spoiler is \(tsSpoiler)")
            Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3
            Engine is \(self.engState.rawValue)
            Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3
            Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%
            Driver's window is \(self.driverWindow.rawValue)
            Passenger's window is \(self.passengerWindow.rawValue)
            Nitrogen speed booster is \(tsNitroActivated)
            """
    }
}

var localTruckCar: TruckCar = TruckCar(model: "KAMAZ", manufactYear: 1976, trunkVolumeMax: 15.2, caravanConnected: true)
var foreignTruckCar: TruckCar = TruckCar(model: "MAN", manufactYear: 2020, trunkVolumeMax: 18, caravanConnected: true)

print(localTruckCar)
localTruckCar.loadTrunk(volume: 7)
localTruckCar.cmdToWindow(window: "Driver", cmd: .open)
localTruckCar.cmdToEngine(cmd: .start)
localTruckCar.cmdToEngine(cmd: .accelerate)
print(localTruckCar)

print(foreignTruckCar)
foreignTruckCar.loadTrunk(volume: 20)
foreignTruckCar.unloadTrunk(volume: 9)
foreignTruckCar.cmdToWindow(window: "Passenger", cmd: .open)
foreignTruckCar.cmdToEngine(cmd: .start)
foreignTruckCar.cmdToEngine(cmd: .accelerate)
print(foreignTruckCar)

var localSportCar: SportCar = SportCar(model: "MARUSSIA", manufactYear: 2013, trunkVolumeMax: 0.025, nitroInstalled: false, airSpoilerInstalled: true)
var foreignSportCar: SportCar = SportCar(model: "PORSCHE", manufactYear: 2019, trunkVolumeMax: 0.02, nitroInstalled: true, airSpoilerInstalled: true)

print(localSportCar)
localSportCar.loadTrunk(volume: 0.01)
localSportCar.cmdToWindow(window: "Passenger", cmd: .open)
localSportCar.cmdToEngine(cmd: .start)
localSportCar.cmdToEngine(cmd: .accelerate)
print(localSportCar)

print(foreignSportCar)
foreignSportCar.loadTrunk(volume: 1)
foreignSportCar.unloadTrunk(volume: 0.005)
foreignSportCar.cmdToWindow(window: "Driver", cmd: .open)
foreignSportCar.cmdToEngine(cmd: .start)
foreignSportCar.cmdToEngine(cmd: .accelerate)
print(foreignSportCar)
