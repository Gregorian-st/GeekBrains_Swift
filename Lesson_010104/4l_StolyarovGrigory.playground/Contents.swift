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

class Car {
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
    func cmdToWindow(window: String, cmd: WindowCmd) {
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
    func loadTrunk(volume: Float) {
        self.trunkVolumeFill += volume
    }
    func unloadTrunk(volume: Float) {
        self.trunkVolumeFill -= volume
    }
    func getCarStatus() {
        print("\n Car model is \(self.model)")
        print("Manufacturing year: \(self.manufactYear)")
        print("Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3")
        print("Engine is \(self.engState.rawValue)")
        print("Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3")
        print("Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%")
        print("Driver's window is \(self.driverWindow.rawValue)")
        print("Passenger's window is \(self.passengerWindow.rawValue)")
    }
    init(model: String, manufactYear: UInt16, trunkVolumeMax: Float) {
        self.model = model
        self.manufactYear = manufactYear
        self.trunkVolumeMax = trunkVolumeMax
    }
}

// В задании опечатка - грузовик по-английски TruckCar, а не TrunkCar
class TruckCar: Car {
    var caravanConnected: Bool
    override func getCarStatus() {
        print("\n TruckCar model is \(self.model)")
        print("Manufacturing year: \(self.manufactYear)")
        print("Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3")
        let ts: String = self.caravanConnected ? "connected" : "not connected"
        print("Caravan is \(ts)")
        print("Engine is \(self.engState.rawValue)")
        print("Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3")
        print("Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%")
        print("Driver's window is \(self.driverWindow.rawValue)")
        print("Passenger's window is \(self.passengerWindow.rawValue)")
    }
    init(model: String, manufactYear: UInt16, trunkVolumeMax: Float, caravanConnected: Bool) {
        self.caravanConnected = caravanConnected
        super.init(model: model, manufactYear: manufactYear, trunkVolumeMax: trunkVolumeMax)
    }
}

class SportCar: Car {
    var airSpoilerInstalled: Bool
    var nitroInstalled: Bool
    var nitroActivated: Bool = false {
        didSet {
            if !nitroInstalled { self.nitroActivated = false}
        }
    }
    func activateNitro(activate act: Bool) {
        self.nitroActivated = act
    }
    override func cmdToEngine(cmd: EngineCmd) {
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
    override func getCarStatus() {
        print("\n SportCar model is \(self.model)")
        print("Manufacturing year: \(self.manufactYear)")
        var ts: String = self.nitroInstalled ? "installed" : "not installed"
        print("Nitrogen speed booster is \(ts)")
        ts = self.airSpoilerInstalled ? "installed" : "not installed"
        print("Air spoiler is \(ts)")
        print("Max trunk volume: \(String(format: "%0.3f", self.trunkVolumeMax))m3")
        print("Engine is \(self.engState.rawValue)")
        print("Loaded trunk volume: \(String(format: "%0.3f", self.trunkVolumeFill))m3")
        print("Loading percent: \(String(format: "%0.2f", self.trunkVolumePercent))%")
        print("Driver's window is \(self.driverWindow.rawValue)")
        print("Passenger's window is \(self.passengerWindow.rawValue)")
        ts = self.nitroActivated ? "activated" : "not activated"
        print("Nitrogen speed booster is \(ts)")
    }
    init(model: String, manufactYear: UInt16, trunkVolumeMax: Float, nitroInstalled: Bool, airSpoilerInstalled: Bool) {
        self.nitroInstalled = nitroInstalled
        self.airSpoilerInstalled = airSpoilerInstalled
        super.init(model: model, manufactYear: manufactYear, trunkVolumeMax: trunkVolumeMax)
    }
}

var localTruckCar: TruckCar = TruckCar(model: "KAMAZ", manufactYear: 1976, trunkVolumeMax: 15.2, caravanConnected: true)
var foreignTruckCar: TruckCar = TruckCar(model: "MAN", manufactYear: 2020, trunkVolumeMax: 18, caravanConnected: true)

localTruckCar.getCarStatus()
localTruckCar.loadTrunk(volume: 7)
localTruckCar.cmdToWindow(window: "Driver", cmd: .open)
localTruckCar.cmdToEngine(cmd: .start)
localTruckCar.cmdToEngine(cmd: .accelerate)
localTruckCar.getCarStatus()

foreignTruckCar.getCarStatus()
foreignTruckCar.loadTrunk(volume: 20)
foreignTruckCar.unloadTrunk(volume: 9)
foreignTruckCar.cmdToWindow(window: "Passenger", cmd: .open)
foreignTruckCar.cmdToEngine(cmd: .start)
foreignTruckCar.cmdToEngine(cmd: .accelerate)
foreignTruckCar.getCarStatus()

var localSportCar: SportCar = SportCar(model: "MARUSSIA", manufactYear: 2013, trunkVolumeMax: 0.025, nitroInstalled: false, airSpoilerInstalled: true)
var foreignSportCar: SportCar = SportCar(model: "PORSCHE", manufactYear: 2019, trunkVolumeMax: 0.02, nitroInstalled: true, airSpoilerInstalled: true)

localSportCar.getCarStatus()
localSportCar.loadTrunk(volume: 0.01)
localSportCar.cmdToWindow(window: "Passenger", cmd: .open)
localSportCar.cmdToEngine(cmd: .start)
localSportCar.cmdToEngine(cmd: .accelerate)
localSportCar.getCarStatus()

foreignSportCar.getCarStatus()
foreignSportCar.loadTrunk(volume: 1)
foreignSportCar.unloadTrunk(volume: 0.005)
foreignSportCar.cmdToWindow(window: "Driver", cmd: .open)
foreignSportCar.cmdToEngine(cmd: .start)
foreignSportCar.cmdToEngine(cmd: .accelerate)
foreignSportCar.getCarStatus()
