import SwiftUI
import Voyager
import CoreLocation

struct TraningView: View {
    
    @State private var vm = ViewModel()
    @State private var opacity: Double = 0.2
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            MapView(location: LocationManager.shared.location)
                .opacity(opacity)
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        TraningDataView()
                            .frame(width: UIScreen.main.bounds.width)
                        TraningMapView()
                    }
                }
                .scrollTargetLayout()
                .layoutDirectionBehavior(.fixed)
                .flipsForRightToLeftLayoutDirection(true)
                .scrollTargetBehavior(.viewAligned)
                .onScrollPhaseChange { oldPhase, newPhase, context in
                    if newPhase == .idle {
                        vm.selectGame(context: context)
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
            .safeAreaPadding(.bottom, 80)
        }
        .onFirstAppear {
            vm.checkAvailableLocation()
        }
        .onChange(of: vm.indexView) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 1)) {
                opacity = opacity == 0.2 ? 1.0 : 0.2
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
        
        var indexView = 0
        
        func selectGame(context: ScrollPhaseChangeContext) {
            let bounds = context.geometry.bounds
            let index: Int = Int((bounds.minX) / bounds.width)
            indexView = index
        }
        
        func getColor(_ index: Int) -> Color {
            return indexView == index ? .blue : .white.opacity(0.5)
        }
        
        func checkAvailableLocation() {
            print("checkAvailableLocation")
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
