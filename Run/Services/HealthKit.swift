import Foundation
import HealthKit

@Observable
final class HealthKitManager: NSObject {
    
    static let shared = HealthKitManager()
    
    var manager: HKHealthStore!
    
    let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
    let height = HKObjectType.quantityType(forIdentifier: .height)!
    
    override init() {
        super.init()
        manager = HKHealthStore()
    }
    
    func checkAuthorization() -> Bool {
        switch manager.authorizationStatus(for: stepCount) {
        case .sharingAuthorized:
            return true
        case .notDetermined:
            return false
        case .sharingDenied:
            return true
        @unknown default:
            return true
        }
    }
    
    func getHealthKitPermission() {
        let healthKitTypesToRead: Set<HKSampleType> = [
            HKSampleType.quantityType(forIdentifier: .height)!,
            HKSampleType.quantityType(forIdentifier: .bodyMass)!,
            HKSampleType.quantityType(forIdentifier: .stepCount)!,
            HKSampleType.quantityType(forIdentifier: .heartRate)!,
            HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKSampleType.quantityType(forIdentifier: .runningStrideLength)!
        ]
        Task(priority: .userInitiated) {
            try await manager.requestAuthorization(
                toShare: [],
                read: healthKitTypesToRead
            )
        }
    }
}


extension HealthKitManager {
    
    func getHeight(completion: @escaping (Double?) -> Void) {
        let query = HKSampleQuery(
            sampleType: HKSampleType.quantityType(forIdentifier: .height)!,
            predicate: nil,
            limit: 1,
            sortDescriptors: nil
        ) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let height = result.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
                completion(height)
            } else {
                completion(nil)
            }
        }
        manager.execute(query)
    }
    
    func getBodyMass(completion: @escaping (Double?) -> Void) {
        let query = HKSampleQuery(
            sampleType: HKSampleType.quantityType(forIdentifier: .bodyMass)!,
            predicate: nil,
            limit: 1,
            sortDescriptors: nil
        ) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let mass = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                completion(mass)
            } else {
                completion(nil)
            }
        }
        manager.execute(query)
    }
    
    //
    func getSteps(start: Date, finish: Date, completion: @escaping (Double) -> Void) {
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: finish,
            options: .strictStartDate
        )
        let query = HKStatisticsQuery(
            quantityType: HKQuantityType(.stepCount),
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        manager.execute(query)
    }
    
    //
    func getHeartRate(start: Date, finish: Date, completion: @escaping (Double?) -> Void) {
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: finish,
            options: .strictStartDate)
        let query = HKStatisticsQuery(
            quantityType: HKQuantityType(.heartRate),
            quantitySamplePredicate: predicate,
            options: .discreteAverage
        ) { query, results, error in
            
            print("result getHeartRate: \(results)")
            
            if results == nil {
                completion(nil)
            } else {
                completion(999.999)
            }
        }
        manager.execute(query)
    }
    
    //
    func getRunningStrideLength(start: Date, finish: Date, completion: @escaping (Double?) -> Void) {
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: finish,
            options: .strictStartDate)
        let query = HKSampleQuery(
            sampleType: HKSampleType.quantityType(forIdentifier: .runningStrideLength)!,
            predicate: predicate,
            limit: 1,
            sortDescriptors: nil
        ) { (query, results, error) in
            
            print("results runningStrideLength: \(results)")
            
//            if let result = results?.first as? HKQuantitySample {
//                let height = result.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
//                completion(height)
//            } else {
//                completion(nil)
//            }
        }
        manager.execute(query)
    }

    //
    func getActiveEnergyBurned(start: Date, finish: Date, completion: @escaping (Double?) -> Void) {
        
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: finish,
            options: [])
        let query = HKSampleQuery(
            sampleType: HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
            predicate: predicate,
            limit: 0,
            sortDescriptors: nil,
            resultsHandler: { (query, results, error) in
                if let results = results {
                    let listHKQuantitySample = results as! [HKQuantitySample]
                    let values = listHKQuantitySample.map({ $0.quantity.doubleValue(for: HKUnit.kilocalorie()) })
                    let kilocalorieTotal = values.reduce(0, +)
                    completion(kilocalorieTotal)
                }
            })
        manager.execute(query)
    }
}
