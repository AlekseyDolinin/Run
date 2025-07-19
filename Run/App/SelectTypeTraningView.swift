import SwiftUI
import Voyager
import CoreLocation

struct SelectTypeTraningView: View {
    
    @State private var vm = ViewModel()
    @EnvironmentObject var router: Router<AppRoute>
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Button(action: {
                    router.present(.ready, option: .fullscreenCover)
                }) {
                    Image(systemName: "figure.run").font(.system(size: 40))
                        .tint(.white)
                        .frame( width: 100, height: 100)
                }
                .background(AppTheme.accentColor)
                .cornerRadius(16)
            }
        }
        .onFirstAppear {
            vm.checkServicesAuthorization()
        }
        
        .onChange(of: vm.showLocationDescriptionView) {
            router.present(.locationDescriptionView, option: .fullscreenCover)
        }
        
        .onChange(of: vm.showHealthDescriptionView) {
            router.present(.healthKitDescriptionView, option: .fullscreenCover)
        }
    }
}

#Preview {
    SelectTypeTraningView()
}


extension SelectTypeTraningView {
    
    @Observable
    class ViewModel {
        
        var showLocationDescriptionView = false
        var showHealthDescriptionView = false
        
        func checkServicesAuthorization() {
            if LocationManager.shared.checkAuthorization() == false {
                showLocationDescription()
            } else {
                checkAuthorizationHealhkit()
            }
        }
        
        private func showLocationDescription() {
            Task(priority: .userInitiated) {
                try? await Task.sleep(nanoseconds: 200_000_000)
                showLocationDescriptionView = true
            }
        }
        
        func checkAuthorizationHealhkit() {
            if HealthKitManager.shared.checkAuthorization() == false {
                Task(priority: .userInitiated) {
                    try? await Task.sleep(nanoseconds: 200_000_000)
                    showHealthDescriptionView = true
                }
            }
        }
    }
}
