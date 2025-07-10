import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var manager: CLLocationManager!
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        // точность
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func checkAuth() {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("authorizedAlways")
            startUpdatingHeading()
        case .notDetermined:
            print("Статус отслеживания геопозиции не определён")
            manager.requestAlwaysAuthorization()
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
    
    private func startUpdatingHeading() {
//        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Пользователь разрешил использовать геопозицию")
            startUpdatingHeading()
        case .restricted, .denied:
            print("Пользователь запретил использовать геопозицию")
        case .notDetermined:
            print("Разрешение еще не определено")
        default:
            break
        }
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        curentLocation = locValue
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("---")
        print(cardinalValue(from: newHeading.trueHeading))
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
    
    
    
    func cardinalValue(from heading: CLLocationDirection) -> String {
            switch heading {
            case 0 ..< 22.5:
                return "N"
            case 22.5 ..< 67.5:
                return "NE"
            case 67.5 ..< 112.5:
                return "E"
            case 112.5 ..< 157.5:
                return "SE"
            case 157.5 ..< 202.5:
                return "S"
            case 202.5 ..< 247.5:
                return "SW"
            case 247.5 ..< 292.5:
                return "W"
            case 292.5 ..< 337.5:
                return "NW"
            case 337.5 ... 360.0:
                return "N"
            default:
                return ""
            }
        }
}
