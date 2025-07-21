import Foundation

class Traning {
    
    var startDate: Date
    var finishDate: Date?
    @Published var duration: Int
    var stateTracking: TrackingState
    var stepCount: Double
    var activeEnergyBurned: Double
    var heartRateAverage: Double
    var distance_km: Double
    var tempAverage: Double
    var speedAverage: Double
    
    init(
        startDate: Date = Date.now,
        finishDate: Date? = nil,
        duration: Int = 0,
        stateTracking: TrackingState = .paused,
        stepCount: Double = 0,
        activeEnergyBurned: Double = 0,
        heartRateAverage: Double = 0,
        distance_km: Double = 0,
        tempAverage: Double = 0,
        speedAverage: Double = 0
    ) {
        self.startDate = startDate
        self.finishDate = finishDate
        self.duration = duration
        self.stateTracking = stateTracking
        self.stepCount = stepCount
        self.activeEnergyBurned = activeEnergyBurned
        self.heartRateAverage = heartRateAverage
        self.distance_km = distance_km
        self.tempAverage = tempAverage
        self.speedAverage = speedAverage
    }
    
    private var timer: Timer!
    private var periodUpdate = 30
    
}


extension Traning {
    
    func start() {
        print("START")
        startTimerTracking()
        stateTracking = .tracking
        LocationManager.shared.manager.startUpdatingLocation()
    }
    
    func pause() {
        print("PAUSE")
        timer.invalidate()
        stateTracking = .paused
        LocationManager.shared.manager.stopUpdatingLocation()
    }
    
    func resume() {
        print("RESUME")
        startTimerTracking()
        stateTracking = .tracking
        LocationManager.shared.manager.startUpdatingLocation()
    }
    
    func stop() {
        print("STOP")
        Task(priority: .userInitiated) {
            await saveTraning()
        }
        timer.invalidate()
        timer = nil
        duration = 0
        LocationManager.shared.manager.stopUpdatingLocation()
    }
    
    private func startTimerTracking() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { _ in
            self.duration += 1
            self.updateDistance()
            self.updateTemp()
            self.updateSpeed()
        }
    }
    
    private func updateDistance() {
        let distanceInMeters = LocationManager.shared.totalDistance
        self.distance_km = distanceInMeters / 1000
    }
    
    private func updateTemp() {
        if duration % periodUpdate != 0 { return }
        let timingTrackingInMinutes = Double(duration) / 60.0
        self.tempAverage = timingTrackingInMinutes / distance_km
    }
    
    private func updateSpeed() {
        if duration % periodUpdate != 0 { return }
        if stateTracking == .tracking {
            speedAverage = LocationManager.shared.location.speed * 3.6
        } else {
            speedAverage = 0
        }
    }
    
    private func saveTraning() async {
        print("saveTraning")
    }
}





// НАСТРОЙКИ ТРЕНИРОВКИ

// 1. период обновления
