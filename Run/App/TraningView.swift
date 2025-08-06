import SwiftUI
import Voyager

struct TraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
        
    @State private var traning = Traning()
    @State private var showAlertStopTracking = false
    
    var body: some View {
        ZStack {
            MapView()
            Color.black
                .opacity(0.8)
            VStack(alignment: .leading, spacing: 100) {
                TraningDataView(traning: traning)
                HStack(alignment: .center, spacing: 40) {
                    if traning.stateTracking == .tracking {
                        Button(action: {
                            traning.pause()
                        }) {
                            Image(systemName: "pause.fill").font(.system(size: 36))
                                .tint(AppTheme.bg_one)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                    }
                    if traning.stateTracking == .paused {
                        Button(action: {
                            showAlertStopTracking.toggle()
                        }) {
                            Image(systemName: "stop.circle")
                                .fontWeight(.light)
                                .font(.system(size: 56))
                                .tint(.white)
                                .frame( width: 80, height: 80)
                                .opacity(0.75)
                        }
                        Button(action: {
                            traning.resume()
                        }) {
                            Image(systemName: "play.fill").font(.system(size: 38))
                                .tint(AppTheme.bg_one)
                                .frame( width: 80, height: 80)
                        }
                        .background(.white)
                        .cornerRadius(16)
                        Button(action: {
                            router.present(.modalSettingTraning, option: .popover)
                        }) {
                            Image(systemName: "gearshape")
                                .fontWeight(.light)
                                .font(.system(size: 48))
                                .tint(.white)
                                .frame( width: 80, height: 80)
                                .opacity(0.75)
                        }
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
        .alert("Завершить тренировку?", isPresented: $showAlertStopTracking) {
            Button( "Отмена", role: .cancel) { }
            Button( "Завершить", role: .destructive) {
                traning.saveTraning()
                router.updateRoot(.statistic)
                router.present(.traningDetail)
            }
        }
    }
}

#Preview {
    TraningView()
}
