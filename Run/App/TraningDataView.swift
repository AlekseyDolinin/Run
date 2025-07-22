import SwiftUI
import Voyager

struct TraningDataView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    var traning: Traning
    
    @State private var duration = ""
    
    var body: some View {
//        let _ = Self._printChanges()
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: -8) {
                        Text(duration)
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Время")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f", traning.distance_km))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Дистанция (км)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f",  traning.tempAverage))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Темп (мин)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f",  traning.activeEnergyBurned))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Калории")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(String(format: "%0.2f",  traning.speedAverage))
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Скорость (км/ч)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .onReceive(traning.$duration) { value in
            self.duration = vm.getDuration(value)
        }
    }
}

#Preview {
    TraningDataView(traning: Traning())
}


extension TraningDataView {
    
    @Observable
    class ViewModel {
                    
        func getDuration(_ second: Int) -> String {
            if second == 0 {
                return "00:00:00"
            } else {
                let hours = String(format: "%02d", second / 3600)
                let minutes = String(format: "%02d", (second % 3600) / 60)
                let seconds = String(format: "%02d", (second % 3600) % 60)
                return "\(hours):\(minutes):\(seconds)"
            }
        }
        
        
//        func getSpeed() -> String {
//            if LocationManager.shared.state == .tracking {
//                if let location = LocationManager.shared.location {
//                    return String(format: "%0.2f",  location.speed * 3.6)
//                } else {
//                    return "0.00"
//                }
//            } else {
//                return "0.00"
//            }
//        }
        


        
//        func getCalories() -> String {
////            let timingTrackingInMinutes = LocationManager.shared.timingTracking / 60
////            let distanceInKm = LocationManager.shared.totalDistance / 1000
////            let value = timingTrackingInMinutes / distanceInKm
////            return String(format: "%0.2f",  value)
//            
//            return "000"
//        }
    }
}
