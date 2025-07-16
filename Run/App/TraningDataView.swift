import SwiftUI
import Voyager

struct TraningDataView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: -8) {
                        Text(vm.getTimingTracking())
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Время")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(vm.getTrackingDistance())
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Дистанция (км)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(vm.getTemp())
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Темп (мин)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(vm.getCalories())
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Калории")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text(vm.getSpeed())
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
    }
}

#Preview {
    TraningDataView()
}


extension TraningDataView {
    
    @Observable
    class ViewModel {
        
        func getSpeed() -> String {
            if LocationManager.shared.state == .tracking {
                if let location = LocationManager.shared.location {
                    return String(format: "%0.2f",  location.speed * 3.6)
                } else {
                    return "0.00"
                }
            } else {
                return "0.00"
            }
        }
        
        func getTimingTracking() -> String {
            if LocationManager.shared.timingTracking == 0 {
                return "00:00:00"
            } else {
                let totalSeconds = Int(LocationManager.shared.timingTracking)
                let hours = String(format: "%02d", totalSeconds / 3600)
                let minutes = String(format: "%02d", (totalSeconds % 3600) / 60)
                let seconds = String(format: "%02d", (totalSeconds % 3600) % 60)
                return "\(hours):\(minutes):\(seconds)"
            }
        }
        
        func getTrackingDistance() -> String {
            let distanceInMeters = LocationManager.shared.totalDistance
            let distanceInKm = distanceInMeters / 1000
            return String(format: "%0.2f",  distanceInKm)
        }
        
        func getTemp() -> String {
            let timingTrackingInMinutes = LocationManager.shared.timingTracking / 60
            let distanceInKm = LocationManager.shared.totalDistance / 1000
            let value = timingTrackingInMinutes / distanceInKm
            return String(format: "%0.2f",  value)
        }
        
        func getCalories() -> String {
//            let timingTrackingInMinutes = LocationManager.shared.timingTracking / 60
//            let distanceInKm = LocationManager.shared.totalDistance / 1000
//            let value = timingTrackingInMinutes / distanceInKm
//            return String(format: "%0.2f",  value)
            
            return "000"
        }
    }
}
