import SwiftUI
import Voyager
import CoreLocation

struct NewTraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()

    var body: some View {
        ZStack {
            AppTheme.bg_one
            VStack(spacing: -20) {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            
                            Rectangle()
                                .fill(.red)
                                .frame(width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)
                            
                            TraningMapView()
                                .frame(width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)
                        }
                        .scrollTargetLayout()
//                        .frame(height: 200)
//                        .padding(.bottom, 48)
                    }
                    .layoutDirectionBehavior(.fixed)
                    .flipsForRightToLeftLayoutDirection(true)
                    .scrollTargetBehavior(.viewAligned)
                    .ignoresSafeArea()
                    .onScrollPhaseChange { oldPhase, newPhase, context in
                        if newPhase == .idle {
                            vm.selectGame(context: context)
                        }
                    }
                }
            }
            ZStack {
                VStack {
                    Spacer()
                    LazyHStack(alignment: .bottom, spacing: 8) {
                        Circle()
                            .foregroundStyle(vm.getColor(0))
                            .frame(width: 8, height: 8)
                        Circle()
                            .foregroundStyle(vm.getColor(1))
                            .frame(width: 8, height: 8)
                    }
                    .frame(height: 20)
                }
            }
            .safeAreaPadding(.bottom, 96)
        }
        .ignoresSafeArea()
        .onFirstAppear {
            vm.checkAvailableLocation()
        }
    }
}

#Preview {
    NewTraningView()
}


extension NewTraningView {
    
    @Observable
    class ViewModel {
        
        var indexSelectGame = 0
                
        func selectGame(context: ScrollPhaseChangeContext) {
            let bounds = context.geometry.bounds
            let index: Int = Int((bounds.minX) / bounds.width)
            indexSelectGame = index
        }
        
        func getColor(_ index: Int) -> Color {
            return indexSelectGame == index ? .blue : .white.opacity(0.5)
        }
        
        func checkAvailableLocation() {
#if targetEnvironment(simulator)
            LocationManager.shared.checkAuth()
#else
            if CLLocationManager.headingAvailable() {
                LocationManager.shared.checkAuth()
            } else {
                print("Disable compass features")
            }
#endif
        }
    }
}
