import Foundation
import Combine
import SwiftData

//@Model
@Observable
class Traning {
    
    var startDate: Date
    var finishDate: Date?
    var duration: Int
    var stateTracking: TrackingState
    var stepCount: Int
    var heartRateAverage: Double
    var distance_km: Double
    var tempAverage: Double
    var speedAverage: Double
    var calories: Int
    
    init(
        startDate: Date = Date.now,
        finishDate: Date? = nil,
        duration: Int = 0,
        stateTracking: TrackingState = .paused,
        stepCount: Int = 0,
        heartRateAverage: Double = 0,
        distance_km: Double = 0,
        tempAverage: Double = 0,
        speedAverage: Double = 0,
        calories: Int = 0
    ) {
        self.startDate = startDate
        self.finishDate = finishDate
        self.duration = duration
        self.stateTracking = stateTracking
        self.stepCount = stepCount
        self.heartRateAverage = heartRateAverage
        self.distance_km = distance_km
        self.tempAverage = tempAverage
        self.speedAverage = speedAverage
        self.calories = calories
    }
    
    private var timer: Timer!
    private var periodUpdate = 10
    
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
        finishDate = Date.now
        stateTracking = .paused
        LocationManager.shared.manager.stopUpdatingLocation()
        
    }
    
    func resume() {
        print("RESUME")
        startTimerTracking()
        stateTracking = .tracking
        LocationManager.shared.manager.startUpdatingLocation()
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
            self.updateCalories()
        }
    }
    
    private func updateDistance() {
        let distanceInMeters = LocationManager.shared.totalDistance
        distance_km = distanceInMeters / 1000
        if distance_km < 0 {
            print("Невозможно получить дистанцию из Core Location")
            print("Необходимо расчитать достанцию по шагам")
        }
    }
    
    private func updateTemp() {
        if duration % periodUpdate != 0 { return }
        let timingTrackingInMinutes = Double(duration) / 60.0
        tempAverage = timingTrackingInMinutes / distance_km
        print("tempAverage: \(tempAverage)")
    }
    
    private func updateSpeed() {
        if duration % periodUpdate != 0 { return }
        if stateTracking == .tracking {
            speedAverage = LocationManager.shared.location.speed * 3.6
        } else {
            speedAverage = 0
        }
        print("speedAverage: \(speedAverage)")
    }
    
    private func updateCalories() {
//        Расход энергии (ккал) = 0,014 * М * t * (0,12 * П - 7)
//        М - вес тела человека, t - время бега, П - средний пульс во время бега

//        Для приблизительного расчета сжигаемых калорий при беге можно использовать формулу: 1 килокалория (ккал) на 1 килограмм веса на 1 километр пути. Более точные расчеты требуют учета скорости, рельефа, погодных условий и индивидуальных особенностей.
        
        if duration % periodUpdate != 0 { return }
        calories = Int(HealthKitManager.shared.bodyMass * distance_km)
    }
    
    func saveTraning() {
        print("saveTraning")
        
    }
}





// НАСТРОЙКИ ТРЕНИРОВКИ

// 1. период обновления
