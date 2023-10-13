// 4-StationModule-ი With properties: moduleName: String და drone: Drone? (optional). Method რომელიც დრონს მისცემს თასქს.

class StationModule { // ყველას რომ გვიერორებდა მაგიტო წერია სულ ზემოთ :დ
    let moduleName: String
    var drone: Drone?
    
    init(moduleName: String, drone: Drone?) {
        self.moduleName = moduleName
        self.drone = drone
    }
    
    func assignTask(task: String) {
        drone?.task = task
    }
}

// 1-ControlCenter-ი. With properties: isLockedDown: Bool და securityCode: String, რომელშიც იქნება რაღაც პაროლი შენახული. Method lockdown, რომელიც მიიღებს პაროლს, ჩვენ დავადარებთ ამ პაროლს securityCode-ს და თუ დაემთხვა გავაკეთებთ lockdown-ს. Method-ი რომელიც დაგვიბეჭდავს ინფორმაციას lockdown-ის ქვეშ ხომ არაა ჩვენი ControlCenter-ი.

class ControlCenter: StationModule { // + task5 subclass
    var isLockedDown: Bool
    private let securityCode: String // task 10: private დავუმატე რადგან კლასის გარეთ ამ ცვლადთან წვდომა არ უნდა მქონდეს. მხოლოდ შეყვანილ პაროლთან შესადარებლად ვიყენებთ ქვემოთ ფუნქციაში.
    
    init(isLockedDown: Bool, securityCode: String) {
        self.isLockedDown = isLockedDown
        self.securityCode = securityCode
        super.init(moduleName: "Control Center", drone: nil)
    }
    
    func lockdown(password: String) {
        if password == securityCode {
            isLockedDown = true
            print("Password is correct. Lockdown is activated!")
        } else {
            print("Password is incorrect. Lockdown is not activated.")
        }
    }
    
    func reportLockdownStatus() {
        if isLockedDown {
            print("Control Center is under lockdown.")
        } else {
            print("Control Center is not under lockdown.")
        }
    }
}

// 2-ResearchLab-ი. With properties: String Array - ნიმუშების შესანახად. Method რომელიც მოიპოვებს(დაამატებს) ნიმუშებს ჩვენს Array-ში.

class ResearchLab: StationModule { // + task5 subclass
    private var samples: [String] // task 10. აქაც private დავამატე, რადგან ნიმუშების array მხოლოდ შესანახად მჭირდება პირობის მიხედვით. ჩავთვალოთ რო შინაარსი საიდუმლოა და მისი წაკითხვა არ უნდა შეიძლებოდეს. მხოლოდ ემატება შიგნით string მნიშვნელობები, ისიც ფუნქციის მეშვეობით 57-ე ხაზიდან.
    
    init(samples: [String]) {
        self.samples = samples
        super.init(moduleName: "Research Lab", drone: nil)
    }
    
    func addSamples(newSample: String) {
        samples.append(newSample)
    }
}

// 3-LifeSupportSystem-ა. With properties: oxygenLevel: Int, რომელიც გააკონტროლებს ჟანგბადის დონეს. Method რომელიც გვეტყვის ჟანგბადის სტატუსზე.

class LifeSupportSystem: StationModule { // + task5 subclass
    private var oxygenLevel: Int // task 10. აქაც რადგანაც კლასის გარედან წვდომა არ მჭირდება oxygenLevel-თან, ამიტომ იყოს private. ფუნქცია 72-ე ხაზიდან მაინც იმუშავებს. ამოცანაში რომ გვქონოდა დამატებითი პირობა, რომ კლასის გარედან რამე ზემოქმედებს ჟანგბადის დონეზე (მაგალითად ადამიანების რაოდენობა თითოეულ მოდულში, თითოეულის ჟანგბადის მოხმარების დონე და ა.შ.), მაშინ private არ იქნებოდა.
    
    init(oxygenLevel: Int) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: "Life Support System", drone: nil)
    }
    
    func reportOxygenStatus() {
        print("Current oxygen level is: \(oxygenLevel)")
    }
}

// 6-Drone. With properties: task: String? (optional), unowned var assignedModule: StationModule, weak var missionControlLink: MissionControl? (optional). Method რომელიც შეამოწმებს აქვს თუ არა დრონს თასქი და თუ აქვს დაგვიბჭდავს რა სამუშაოს ასრულებს ის.

class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    
    init(task: String? = nil, assignedModule: StationModule, missionControlLink: MissionControl? = nil) {
        self.task = task
        self.assignedModule = assignedModule
        self.missionControlLink = missionControlLink
    }
    
    func hasTask() {
        if task != nil {
            print("Task of this drone is: \(task!).")
        } else {
            print("This drone does not have a task.")
        }
    }
}

// 7-OrbitronSpaceStation-ი შევქმნათ, შიგნით ავაწყოთ ჩვენი მოდულები ControlCenter-ი, ResearchLab-ი და LifeSupportSystem-ა. ასევე ამ მოდულებისთვის გავაკეთოთ თითო დრონი და მივაწოდოთ ამ მოდულებს რათა მათ გამოყენება შეძლონ. ასევე ჩვენს OrbitronSpaceStation-ს შევუქმნათ ფუნქციონალი lockdown-ის რომელიც საჭიროების შემთხვევაში controlCenter-ს დალოქავს.

class OrbitronSpaceStation {
    let controlCenter = ControlCenter(isLockedDown: false, securityCode: "qwerty")
    let researchLab = ResearchLab(samples: [])
    let lifeSupportSystem = LifeSupportSystem(oxygenLevel: 100)
    
    init() {
        let droneCC: Drone = Drone(assignedModule: controlCenter)
        let droneRL: Drone = Drone(assignedModule: researchLab)
        let droneLSS: Drone = Drone(assignedModule: lifeSupportSystem)
        
        controlCenter.drone = droneCC
        researchLab.drone = droneRL
        lifeSupportSystem.drone = droneLSS
    }
    
    func lockdown(password: String) {
        controlCenter.lockdown(password: password)
    }
}

// 8-MissionControl. With properties: spaceStation: OrbitronSpaceStation? (optional). Method რომ დაუკავშირდეს OrbitronSpaceStation-ს და დაამყაროს მასთან კავშირი. Method requestControlCenterStatus-ი. Method requestOxygenStatus-ი. Method requestDroneStatus რომელიც გაარკვევს რას აკეთებს კონკრეტული მოდულის დრონი.

class MissionControl {
    var spaceStation: OrbitronSpaceStation?
    
    func connectToStation(station: OrbitronSpaceStation) {
        spaceStation = station
    }
    
    func requestControlCenterStatus() {
        spaceStation?.controlCenter.reportLockdownStatus()
    }
    
    func requestOxygenStatus() {
        spaceStation?.lifeSupportSystem.reportOxygenStatus()
    }
    
    func requestDroneStatus(module: StationModule) {
        module.drone?.hasTask()
    }
}

// 9-და ბოლოს შევქმნათ OrbitronSpaceStation, შევქმნათ MissionControl-ი, missionControl-ი დავაკავშიროთ OrbitronSpaceStation სისტემასთან, როცა კავშირი შედგება missionControl-ით მოვითხოვოთ controlCenter-ის status-ი. controlCenter-ის, researchLab-ის და lifeSupport-ის მოდულების დრონებს დავურიგოთ თასქები. შევამოწმოთ დრონების სტატუსები. შევამოწმოთ ჟანგბადის რაოდენობა. შევამოწმოთ ლოქდაუნის ფუნქციონალი და შევამოწმოთ დაილოქა თუ არა ხომალდი სწორი პაროლი შევიყვანეთ თუ არა.

let ourStation = OrbitronSpaceStation()
let ourMissionControl = MissionControl()

ourMissionControl.connectToStation(station: ourStation)

ourMissionControl.requestControlCenterStatus()

ourStation.controlCenter.assignTask(task: "Check security status")
ourStation.researchLab.assignTask(task: "Analyse area for new samples")
ourStation.lifeSupportSystem.assignTask(task: "Check oxygen level")

ourMissionControl.requestDroneStatus(module: ourStation.controlCenter)
ourMissionControl.requestDroneStatus(module: ourStation.researchLab)
ourMissionControl.requestDroneStatus(module: ourStation.lifeSupportSystem)

ourStation.lifeSupportSystem.reportOxygenStatus() // იბეჭდება მიუხედავად იმისა რომ oxygenLevel private გახდა

ourStation.lockdown(password: "random")
ourStation.controlCenter.reportLockdownStatus()
ourStation.lockdown(password: "qwerty")
ourStation.controlCenter.reportLockdownStatus()


// 50-3 ხაზზე რომ private დავამატე sample array-ს, აქ ვამოწმებ რომ მაგის მიუხედავად მაინც შემიძლია ნიმუშების array-ში string-ების ჩამატება ფუნქციით. თუმცა თვითონ array-ს ვერ მივწვდები და ვერ ვნახავ შიგნით რა წერია
ourStation.researchLab.addSamples(newSample: "test sample")
