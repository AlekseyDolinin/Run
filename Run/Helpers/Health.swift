import HealthKit

final class Health {
        
    static let shared = Health()
    
    let healthKitStore = HKHealthStore()
    
    func ckeckAuthHealthKit() async -> HKAuthorizationStatus {
        let hkObjectType: HKObjectType = .workoutType()
        let status = healthKitStore.authorizationStatus(for: hkObjectType)
        return status
    }
    
    func authRequest() {
        let allTypes: Set = [
            HKQuantityType.workoutType(),            
            HKQuantityType(.heartRate),
            HKQuantityType(.distanceWalkingRunning),
            HKQuantityType(.runningSpeed),
            HKQuantityType(.distanceWalkingRunning)
        ]
        // Check that Health data is available on the device.
        if HKHealthStore.isHealthDataAvailable() {
            // Asynchronously request authorization to the data.
            Task(priority: .userInitiated) {
                try await healthKitStore.requestAuthorization(
                    toShare: allTypes,
                    read: allTypes
                )
            }
        }
    }
}
