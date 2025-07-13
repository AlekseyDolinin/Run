import SwiftUI
import Voyager

struct TraningDataView: View {
    
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
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
                Spacer(minLength: 8)
                    .background(.green)
                    .foregroundStyle(.blue)
                HStack(alignment: .center, spacing: 64) {
                    if LocationManager.shared.state == .stop {
                        Button(action: {
                            LocationManager.shared.start()
                        }) {
                            Image(systemName: "figure.run").font(.system(size: 36))
                                .tint(.white)
                                .frame( width: 80, height: 80)
                        }
                        .background(AppTheme.accentColor)
                        .cornerRadius(16)
                    }
                    if LocationManager.shared.state == .tracking {
                        Button(action: {
                            LocationManager.shared.pause()
                        }) {
                            Image(systemName: "pause.fill").font(.system(size: 36))
                                .tint(AppTheme.accentColor)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                    }
                    if LocationManager.shared.state == .paused {
                        Button(action: {
                            LocationManager.shared.stop()
                        }) {
                            Image(systemName: "stop.fill").font(.system(size: 36))
                                .tint(AppTheme.accentColor)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                        Button(action: {
                            LocationManager.shared.resume()
                        }) {
                            Image(systemName: "play.fill").font(.system(size: 38))
                                .tint(AppTheme.accentColor)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 64)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 140)
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
            if let location = LocationManager.shared.location {
                return "\(location.speed)"
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
        
        func setButtonsNAvigation() {
            
        }
    }
}
