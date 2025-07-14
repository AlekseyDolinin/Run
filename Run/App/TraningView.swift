import SwiftUI
import Voyager
import CoreLocation

struct TraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    var body: some View {
        ZStack {
            MapView()
//            Color.black
//                .opacity(0.85)
            VStack(alignment: .leading, spacing: 100) {
                TraningDataView()
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
                            router.updateRoot(.statistic)
                            router.present(.traningDetail)
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
            .safeAreaPadding(.horizontal)
            .safeAreaPadding(.bottom, 64)
        }
        .ignoresSafeArea()
        .onFirstAppear {
            LocationManager.shared.start()
        }
    }
}

#Preview {
    TraningView()
}
