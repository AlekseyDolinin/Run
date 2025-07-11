import SwiftUI
import CoreLocation
import UIKit
//import MapKit

struct TraningMapView: View {
                    
    var body: some View {
        ZStack {
            AppTheme.bg_one
            MapView(location: LocationManager.shared.location)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onChange(of: LocationManager.shared.location) { _, location in
            
            
        }
    }
}

#Preview {
    TraningMapView()
}



struct MapView: UIViewControllerRepresentable {
    
    @State var location: CLLocation!
    
    func makeUIViewController(context: Context) -> UIViewController {
        return TraningMapVC()
    }

    func updateUIViewController(_ viewController: UIViewController, context: Context) {        
//        let vc: TraningMapVC = viewController as! TraningMapVC
//        vc.location = location
    }
}
