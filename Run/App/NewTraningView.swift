import SwiftUI
import Voyager

struct NewTraningView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
            VStack(spacing: -20) {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            Rectangle()
                                .fill(.red)
                                .frame(width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)
                            
                            TraningMapView()
                                .frame(width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)
                            
//                            Rectangle()
//                                .fill(.orange)
//                                .frame(width: UIScreen.main.bounds.width,
//                                       height: UIScreen.main.bounds.height)
                        }
                        .scrollTargetLayout()
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
            .safeAreaPadding(.bottom, 88)
        }
        .ignoresSafeArea()
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
    }
}
