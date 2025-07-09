import SwiftUI
import MapKit

struct TraningMapView: View {
    
    @State private var vm = ViewModel()
    @State private var hasTimeElapsed = false
    
    var body: some View {
        ZStack {
            AppTheme.accentColor
            
            Map(initialPosition: vm.getUserPosition(), interactionModes: [.rotate, .zoom])
//                .mapStyle(.imagery)
                .mapStyle(.standard)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .mapControlVisibility(.hidden)
            
            ZStack {
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                }
            }
        }
        .onFirstAppear {
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
        
        
        
        
        
        func getUserPosition() -> MapCameraPosition {
            let userPosition = MapCameraPosition.userLocation(
                followsHeading: true,
                fallback: .automatic
            )
            return userPosition
        }
        
        
        
    }
}
