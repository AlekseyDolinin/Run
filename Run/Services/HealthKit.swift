import Foundation
import HealthKit

@Observable
final class HealthKitManager: NSObject {
    
    static let shared = HealthKitManager()
    
    var manager: HKHealthStore!
    
    var height: Double = 0.0
    var bodyMass: Double = 0.0
    var stepCount: Double = 0.0
    var activeEnergyBurned: Double = 0.0
    var heartRate: Double = 0.0
    
    override init() {
        super.init()
        manager = HKHealthStore()
    }
    
    func checkAuthorization() -> Bool {
        let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
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
            HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
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
    
    func getHeight(){
        createSampleQuery(identifier: .height)
    }
    
    func getBodyMass(){
        createSampleQuery(identifier: .bodyMass)
    }

    func getCountSteps(start: Date, finish: Date) {
        createStatisticsQuery(
            start: start,
            finish: finish,
            identifier: .stepCount,
            options: .cumulativeSum
        )
    }
        
    func getActiveEnergyBurned(start: Date, finish: Date) {
        createStatisticsQuery(
            start: start,
            finish: finish,
            identifier: .activeEnergyBurned,
            options: .cumulativeSum
        )
    }
    
    func getHeartRate(start: Date, finish: Date) {
        createStatisticsQuery(
            start: start,
            finish: finish,
            identifier: .heartRate,
            options: .discreteAverage
        )
    }
    
    //
    private func createSampleQuery(identifier: HKQuantityTypeIdentifier) {
        let query = HKSampleQuery(
            sampleType: HKSampleType.quantityType(forIdentifier: identifier)!,
            predicate: nil,
            limit: 1,
            sortDescriptors: nil
        ) { (query, result, error)  in
            self.parseResultSampleQuery(result, identifier: identifier)
        }
        manager.execute(query)
    }
    
    //
    private func createStatisticsQuery(
        start: Date,
        finish: Date,
        identifier: HKQuantityTypeIdentifier,
        options: HKStatisticsOptions
    ) {
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: finish,
            options: .strictStartDate
        )
        let query = HKStatisticsQuery(
            quantityType: HKQuantityType(identifier),
            quantitySamplePredicate: predicate,
            options: options
        ) { (query, result, error) in
            if error != nil {
                print("---------------------------")
                print(identifier)
                print(query)
                print(result)
                print(error)
                print("---------------------------")
            }
            self.parseResultStatisticsQuery(
                result,
                identifier: identifier
            )
        }
        manager.execute(query)
    }
    
    //
    private func parseResultSampleQuery(
        _ result: [HKSample]?,
        identifier: HKQuantityTypeIdentifier
    ) {
        switch identifier {
        case .height:
            parseHeight(result)
        case .bodyMass:
            parseBodyMass(result)
        default:
            break
        }
    }
    
    //
    private func parseResultStatisticsQuery(
        _ result: HKStatistics?,
        identifier: HKQuantityTypeIdentifier
    ) {
        switch identifier {
        case .stepCount:
            parseStepCount(result)
        case .activeEnergyBurned:
            parseActiveEnergyBurned(result)
        case .heartRate:
            parseHeartRate(result)
        default:
            break
        }
    }
    
    //
    private func parseHeight(_ result: [HKSample]?) {
        if let res = result?.first as? HKQuantitySample {
            height = res.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
        }
    }
    
    //
    private  func parseBodyMass(_ result: [HKSample]?) {
        if let res = result?.first as? HKQuantitySample {
            bodyMass = res.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
        }
    }
    
    //
    private func parseStepCount(_ result: HKStatistics?) {
        if let sum = result?.sumQuantity() {
            stepCount = sum.doubleValue(for: HKUnit.count())
        }
    }
    
    //
    private  func parseActiveEnergyBurned(_ result: HKStatistics?) {
        if let sum = result?.sumQuantity() {
            activeEnergyBurned = sum.doubleValue(for: HKUnit.kilocalorie())
        }
    }
    
    //
    private func parseHeartRate(_ result: HKStatistics?) {
        print("result HeartRate: \(result)")
    }
        
}
