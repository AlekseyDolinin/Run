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
                        Text("00,00")
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Дистанция (км)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text("00:00")
                            .font(.custom("MonomaniacOne-Regular", size: 60))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Темп (мин/км)")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: -8) {
                        Text("000")
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
                    return "\(location.speed)"
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
                let totalSeconds = LocationManager.shared.timingTracking
                let hours = String(format: "%02d", totalSeconds / 3600)
                let minutes = String(format: "%02d", (totalSeconds % 3600) / 60)
                let seconds = String(format: "%02d", (totalSeconds % 3600) % 60)
                return "\(hours):\(minutes):\(seconds)"
            }
        }
    }
}
