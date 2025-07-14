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
                    if vm.checkAvailableLocation() == true {
                        router.present(.ready, option: .fullscreenCover)
                    } else {
                        LocationManager.shared.manager.requestAlwaysAuthorization()
                    }
                }) {
                    Image(systemName: "figure.run").font(.system(size: 40))
                        .tint(.white)
                        .frame( width: 100, height: 100)
                }
                .background(AppTheme.accentColor)
                .cornerRadius(16)
            }
        }
    }
}

#Preview {
    SelectTypeTraningView()
}


extension SelectTypeTraningView {
    
    @Observable
    class ViewModel {
        
        func checkAvailableLocation() -> Bool {
            print("checkAvailableLocation")
#if targetEnvironment(simulator)
            return true
#else
            if CLLocationManager.headingAvailable() {
                switch LocationManager.shared.manager.authorizationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    return true
                default:
                    return false
                }
            } else {
                return false
                print("Disable compass features")
            }
#endif
        }
    }
}
