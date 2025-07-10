//import HealthKit
//
//final class Health {
//        
//    static let shared = Health()
//    
//    let healthStore = HKHealthStore()
//    
//    func ckeckAuthHealthKit() async -> HKAuthorizationStatus {
//        let hkObjectType: HKObjectType = .workoutType()
//        let status = healthStore.authorizationStatus(for: hkObjectType)
//        return status
//    }
//    
//    func authRequest() {
//        let allTypes: Set = [
//            HKQuantityType.workoutType(),            
//            HKQuantityType(.heartRate),
//            HKQuantityType(.distanceWalkingRunning),
//            HKQuantityType(.runningSpeed),
//            HKQuantityType(.distanceWalkingRunning)
//        ]
//        // Check that Health data is available on the device.
//        if HKHealthStore.isHealthDataAvailable() {
//            // Asynchronously request authorization to the data.
//            Task(priority: .userInitiated) {
//                try await healthStore.requestAuthorization(
//                    toShare: allTypes,
//                    read: allTypes
//                )
//            }
//        }
//    }
//    
//
//    private let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//
//    func importStepsHistory() {
//        let now = Date()
//        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: now)!
//
//        var interval = DateComponents()
//        interval.day = 1
//
//        var anchorComponents = Calendar.current.dateComponents([.day, .month, .year], from: now)
//        anchorComponents.hour = 0
//        let anchorDate = Calendar.current.date(from: anchorComponents)!
//
//        let query = HKStatisticsCollectionQuery(
//            quantityType: stepsQuantityType,
//            quantitySamplePredicate: nil,
//            options: [.cumulativeSum],
//            anchorDate: anchorDate,
//            intervalComponents: interval
//        )
//        query.initialResultsHandler = { _, results, error in
//            guard let results = results else {
//                print("Error returned form resultHandler = \(String(describing: error?.localizedDescription))")
//                print(error)
//                return
//            }
//        
//            results.enumerateStatistics(from: startDate, to: now) { statistics, _ in
//                if let sum = statistics.sumQuantity() {
//                    let steps = sum.doubleValue(for: HKUnit.count())
//                    print("Amount of steps: \(steps), date: \(statistics.startDate)")
//                }
//            }
//        }
//        healthStore.execute(query)
//    }
//}
