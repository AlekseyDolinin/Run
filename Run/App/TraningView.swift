import SwiftUI
import Voyager
import CoreLocation

struct TraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            MapView(isMonitoring: vm.isMonitoring)
            Color.black
                .opacity(0.85)
            VStack(alignment: .leading, spacing: 100) {
                TraningDataView()
                HStack(alignment: .center, spacing: 64) {
                    if LocationManager.shared.state == .stop {
                        Button(action: {
                            LocationManager.shared.start()
                            vm.isMonitoring = true
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
                            vm.isMonitoring = false
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
                            vm.showAlertStopTracking = true
                        }) {
                            Image(systemName: "stop.fill").font(.system(size: 36))
                                .tint(AppTheme.accentColor)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                        Button(action: {
                            LocationManager.shared.resume()
                            vm.isMonitoring = true
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
            .safeAreaPadding(.horizontal)
            .safeAreaPadding(.bottom, 64)
        }
        .ignoresSafeArea()
        .onFirstAppear {
            LocationManager.shared.start()
            vm.isMonitoring = true
        }
        .alert("Завершить тренировку?", isPresented: $vm.showAlertStopTracking) {
            Button( "Отмена", role: .cancel) { }
            Button( "Завершить", role: .destructive) {
                LocationManager.shared.stop()
                router.updateRoot(.statistic)
                router.present(.traningDetail)
                vm.isMonitoring = false
            }
        }
    }
}

#Preview {
    TraningView()
}


extension TraningView {
    
    @Observable
    class ViewModel {
        
        var isMonitoring: Bool = true
        var showAlertStopTracking = false
    }
}
