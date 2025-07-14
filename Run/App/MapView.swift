import SwiftUI
import CoreLocation
import UIKit
import MapKit

struct MapView: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> UIViewController {
        return TraningMapVC()
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) { }
}

#Preview {
    MapView()
}


final class TraningMapVC: UIViewController {
    
    private let mapView = MKMapView()
    
    private var breadcrumbs: BreadcrumbPath!
    private var breadcrumbPathRenderer: BreadcrumbPathRenderer?
    private var breadcrumbBoundingPolygon: MKPolygon?
    private let locationManager = CLLocationManager()
    private var isMonitoringLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        createSubviews()
    }

    func trackingAction() {
        if isMonitoringLocation {
            stopRecordingLocation()
        } else {
            startRecordingLocation()
        }
    }
        
    func displayNewBreadcrumbOnMap(_ newLocation: CLLocation) {
        let result = breadcrumbs.addLocation(newLocation)
         if result.locationAdded {
            let currentZoomScale = mapView.bounds.size.width / mapView.visibleMapRect.size.width
            let lineWidth = MKRoadWidthAtZoomScale(currentZoomScale)
            var areaToRedisplay = breadcrumbs.pathBounds
            areaToRedisplay = areaToRedisplay.insetBy(
                dx: -lineWidth,
                dy: -lineWidth
            )
            breadcrumbPathRenderer?.setNeedsDisplay(areaToRedisplay)
        }
        if result.boundingRectChanged {
            updateBreadcrumbBoundsOverlay()
        }
        if breadcrumbs.locations.count == 1 {
            let region = MKCoordinateRegion(
                center: newLocation.coordinate,
                latitudinalMeters: 100,
                longitudinalMeters: 100
            )
            mapView.setRegion(region, animated: true)
            mapView.setUserTrackingMode(
                .followWithHeading,
                animated: true
            )
        }
    }
    
    private func removeBreadcrumbBoundsOverlay() {
        if let breadcrumbBoundingPolygon {
            mapView.removeOverlay(breadcrumbBoundingPolygon)
        }
    }
    
    private func updateBreadcrumbBoundsOverlay() {
       removeBreadcrumbBoundsOverlay()
    }
    
    func startRecordingLocation() {
        if let breadcrumbs {
            mapView.removeOverlay(breadcrumbs)
            breadcrumbPathRenderer = nil
        }
        breadcrumbs = BreadcrumbPath()
        mapView.addOverlay(
            breadcrumbs,
            level: .aboveRoads
        )
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
        isMonitoringLocation = true
    }
    
    func stopRecordingLocation() {
        isMonitoringLocation = false
        locationManager.stopUpdatingLocation()
    }
}


extension TraningMapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? BreadcrumbPath {
            if breadcrumbPathRenderer == nil {
                breadcrumbPathRenderer = BreadcrumbPathRenderer(crumbPath: overlay)
            }
            return breadcrumbPathRenderer!
        } else if overlay is MKPolygon {
            let pathBoundsRenderer = MKPolygonRenderer(overlay: overlay)
            pathBoundsRenderer.fillColor = .systemBlue.withAlphaComponent(0.25)
            return pathBoundsRenderer
        } else {
            fatalError("Unknown overlay \(overlay) added to the map")
        }
    }
}


extension TraningMapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            displayNewBreadcrumbOnMap(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { }
}


extension TraningMapVC {
    
    private func createSubviews() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.showsScale = true
        mapView.userTrackingMode = .followWithHeading
        // 3D Button
        mapView.pitchButtonVisibility = .visible
        // Tracking Button
        mapView.showsUserTrackingButton = true
        // Compass Button
        mapView.showsCompass = true
        mapView.mapType = .mutedStandard
        mapView.showsTraffic = false
        mapView.showsBuildings = false
        mapView.pointOfInterestFilter = .excludingAll
        //
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: -(UIScreen.main.bounds.height / 2)).isActive = true
    }
}
