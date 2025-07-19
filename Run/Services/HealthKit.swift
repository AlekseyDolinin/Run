import Foundation
import HealthKit

@Observable
final class HealthKitManager: NSObject {
    
    static let shared = HealthKitManager()
    
    var manager: HKHealthStore!
    
    let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
    
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
        Task(priority: .userInitiated) {
            try await manager.requestAuthorization(
                toShare: [],
                read: [stepCount]
            )
        }
    }
    
   func getSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType(.stepCount)
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
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
}
