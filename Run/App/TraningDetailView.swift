import SwiftUI
import Voyager

struct TraningDetailView: View {
        
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            VStack() {
                TopBarOnlyBack()
                ScrollView {
                    Rectangle()
                        .frame(height: 400)
                        .foregroundStyle(AppTheme.bg_plate)
                        .cornerRadius(16)
                }
                .scrollIndicators(.hidden)
                .safeAreaPadding()
            }
        }
        .navigationBarHidden(true)
        .onFirstAppear {
            vm.getSteps()
        }
    }
}

#Preview {
    TraningDetailView()
}


extension TraningDetailView {
    
    @Observable
    class ViewModel {
        
        func getSteps() {
            HealthKitManager.shared.getSteps { count in
                print("count steps: \(count)")
            }
        }
    }
}
