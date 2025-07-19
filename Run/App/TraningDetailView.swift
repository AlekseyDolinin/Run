import SwiftUI
import Voyager

struct TraningDetailView: View {
    
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            VStack() {
                TopBarOnlyBack()
                ScrollView {
                    Rectangle()
                        .frame(height: 400)
                        .foregroundStyle(AppTheme.bg_plate)
                        .cornerRadius(16)
                }
                .scrollIndicators(.hidden)
                .safeAreaPadding()
            }
        }
        .navigationBarHidden(true)
        .onFirstAppear {
            vm.getSteps()
        }
    }
}

#Preview {
    TraningDetailView()
}


extension TraningDetailView {
    
    @Observable
    class ViewModel {
        
        func getSteps() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let startString = "2025-07-18T18:17:00"
            let startDate: Date = dateFormatter.date(from: startString)!
            
            let finishStaring = "2025-07-18T18:55:43"
            let finishDate: Date = dateFormatter.date(from: finishStaring)!
            
            print("startDate: \(startDate)")
            print("finishDate: \(finishDate)")
            
            HealthKitManager.shared.getSteps(start: startDate, finish: finishDate) { count in
                print("count steps: \(count)")
                let height = 1.77
                let lenghtStep = height / 100.0 * 55
                print("lenghtStep: \(lenghtStep)")
                let distance = count * lenghtStep
                print("distance: \(distance)")
            }
            
            HealthKitManager.shared.getHeartRate(start: startDate, finish: finishDate) { count in
                print("HeartRate: \(count)")
            }
            HealthKitManager.shared.getHeight { height in
                print("height: \(height)")
            }
            HealthKitManager.shared.getBodyMass { mass in
                print("mass: \(mass)")
            }
            HealthKitManager.shared.getRunningStrideLength(start: startDate, finish: finishDate) { runningStrideLength in
                print("runningStrideLength: \(runningStrideLength)")
            }
            HealthKitManager.shared.getActiveEnergyBurned(start: startDate, finish: finishDate) { energy in
                print("energy: \(energy)")
            }
            HealthKitManager.shared.getActiveEnergyBurned(start: startDate, finish: finishDate) { kilocalorie in
                print("kilocalorie: \(kilocalorie)")
            }
        }
    }
}
