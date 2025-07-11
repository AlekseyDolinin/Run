import CoreLocation

@Observable
final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var manager: CLLocationManager!
        
    var location: CLLocation!
    
    override init() {
        super.init()
        print("INIT LocationManager")
        manager = CLLocationManager()
        manager.delegate = self
        // точность
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuth() {
        print("checkAuth LocationManager")
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("authorizedAlways")
//            startUpdating()
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
    
//    private func startUpdating() {
//        print("startUpdating")
//        manager.startUpdatingLocation()
//        manager.startUpdatingHeading()
//        //
//        manager.pausesLocationUpdatesAutomatically = true
//    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Пользователь разрешил использовать геопозицию")
//            startUpdating()
        case .restricted, .denied:
            print("Пользователь запретил использовать геопозицию")
        case .notDetermined:
            print("Разрешение еще не определено")
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
//            //
//            // Возвращает высоту местоположения.
//            // Может быть положительной (над уровнем моря) или отрицательной (ниже уровня моря).
//            print("altitude: \(location.altitude)")
//            // Возвращает горизонтальную точность местоположения.
//            // Значение отрицательное, если горизонтальное местоположение недействительно.
//            print("horizontalAccuracy: \(location.horizontalAccuracy)")
//            // Возвращает вертикальную точность местоположения.
//            // Значение отрицательное, если высота неверна.
//            print("verticalAccuracy: \(location.verticalAccuracy)")
//            // Возвращает скорость местоположения в м/с.
//            // Значение отрицательное, если скорость недействительна.
//            print("speed: \(location.speed)")
            // Возвращает курс местоположения в градусах истинного севера.
            // Значение отрицательное, если курс недействителен.
//            print("course: \(location.course)")
//            // Возвращает точность курса местоположения в градусах.
//            // Возвращает отрицательное значение, если курс недействителен.
//            print("courseAccuracy: \(location.courseAccuracy)")
//            // Возвращает эллипсоидальную высоту местоположения в системе координат WGS 84.
//            // Может быть положительным или отрицательным.
//            print("ellipsoidalAltitude: \(location.ellipsoidalAltitude)")
//            // Возвращает точность скорости местоположения в м/с.
//            // Возвращает -1, если значение недействительно.
//            print("speedAccuracy: \(location.speedAccuracy)")
//            // Возвращает координаты текущего местоположения.
//            print("coordinate: \(location.coordinate)")
//            print("==================================================================================")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        print(">>>>> \(newHeading.trueHeading)")
    }
}
