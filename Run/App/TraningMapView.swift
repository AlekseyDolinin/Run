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
            AppTheme.bg_one
            Map(position: $userPosition, interactionModes: [.rotate, .zoom])
                .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .mapControlVisibility(.hidden)
                .rotationEffect(vm.degreesToRadians(), anchor: .center)
            
            
        }
        .onChange(of: LocationManager.shared.location) { _, location in
            if let location = location {
                vm.location = location
            }
        }
    }
}

#Preview {
    TraningMapView()
}


extension TraningMapView {
    
    @Observable
    class ViewModel {
        
        var location = CLLocation()
        
        func degreesToRadians() -> Angle {
            let angle = Angle(degrees: CGFloat(location.course * .pi / 180 - 90))
            return angle
        }
    }
}
