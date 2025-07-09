import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var locationManager: CLLocationManager!
    var curentLocation: CLLocationCoordinate2D? {
        didSet {
            print("curentLocation = \(curentLocation)")
        }
    }
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // точность
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func checkAuth() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            print("authorizedAlways")
            startUpdatingLocation()
        case .notDetermined:
            print("Статус отслеживания геопозиции не определён")
            locationManager.requestAlwaysAuthorization()
        case .denied:
            print("Статус отслеживания геопозиции - запрещён")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    func startUpdatingLocation() {
        print("startUpdatingLocation")
        locationManager.startUpdatingLocation()
    }
}


extension  LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Пользователь разрешил использовать геопозицию")
            startUpdatingLocation()
        case .restricted, .denied:
            print("Пользователь запретил использовать геопозицию")
            
        case .notDetermined:
            print("Разрешение еще не определено")
            
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        curentLocation = locValue
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(1)
        print(manager)
        print(newHeading)
    }
    
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("locationManagerDidPauseLocationUpdates")
    }
    
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print("locationManagerDidResumeLocationUpdates")
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        print("locationManagerShouldDisplayHeadingCalibration")
        return true
    }
    
}
