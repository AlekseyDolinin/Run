import SwiftUI
import Voyager
import CoreLocation

struct TraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
        
    @State private var traning = Traning()
    
    var body: some View {
        ZStack {
            MapView()
            Color.black
                .opacity(0.8)
            VStack(alignment: .leading, spacing: 100) {
                TraningDataView(traning: traning)
                HStack(alignment: .center, spacing: 64) {
                    if vm.stateTracking == .tracking {
                        Button(action: {
                            vm.stateTracking = .paused
                            traning.pause()
                        }) {
                            Image(systemName: "pause.fill").font(.system(size: 36))
                                .tint(AppTheme.accentColor)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                    }
                    if vm.stateTracking == .paused {
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
                            vm.stateTracking = .tracking
                            traning.resume()
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
            traning.start()
        }
        .alert("Завершить тренировку?", isPresented: $vm.showAlertStopTracking) {
            Button( "Отмена", role: .cancel) { }
            Button( "Завершить", role: .destructive) {
                traning.stop()
                router.updateRoot(.statistic)
                router.present(.traningDetail)
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
        
        var showAlertStopTracking = false
        var stateTracking: TrackingState = .tracking
        
    }
}
