import SwiftUI
import MapKit

struct TraningMapView: View {
    
    @State private var vm = ViewModel()
    
    @State private var userPosition = MapCameraPosition.userLocation(
        followsHeading: true,
        fallback: .automatic
    )
        
    var body: some View {
        ZStack {
            AppTheme.accentColor
            
            Map(position: $userPosition, interactionModes: [.rotate, .zoom])
                .mapStyle(.standard)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .mapControlVisibility(.hidden)
                .onMapCameraChange(frequency: .continuous) { context in
//                    print("context: \(context)")
                }
        }
        .onFirstAppear {
            vm.updateDeviceMotion()
            vm.checkAvailableLocation()
        }
    }
}

#Preview {
    TraningMapView()
}


extension TraningMapView {
    
    @Observable
    class ViewModel {
        
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
        
        func updateDeviceMotion() {
            print("updateDeviceMotion")
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        
        @objc
        private func fireTimer() {
//            print(MotionManager.shared.manager.deviceMotion?.rotationRate.z)
//            print("-------------------------------------------------")
        }
    }
}
