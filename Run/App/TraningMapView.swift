import SwiftUI
import MapKit

struct TraningMapView: View {
        
    @State private var hasTimeElapsed = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 10, longitude: 10),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    let coordinate = CLLocationCoordinate2D(latitude: 10, longitude: 10)
    
    var body: some View {
        ZStack {
            AppTheme.accentColor
            Map(initialPosition: startPosition, interactionModes: []) {
                Marker("111", coordinate: coordinate)
            }
                .mapStyle(.imagery)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
        }
//        .onAppear {
//            let startPosition = MapCameraPosition.region(
//                MKCoordinateRegion(
//                    center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
//                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
//                )
//            )
//        }
    }
}

#Preview {
    NewTraningView()
}
