import CoreLocation

@Observable
final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var manager: CLLocationManager!
    var location: CLLocation!
    var timer: Timer!
    var timingTracking: Double = 0
    var state: TrackingState = .stop
    var totalDistance: Double = 0
    
    enum TrackingState {
        case stop
        case ready
        case tracking
        case paused
    }
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        // точность
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start() {
        state = .tracking
        manager.startUpdatingLocation()
        startTimerTracking()
    }
    
    func pause() {
        state = .paused
        manager.stopUpdatingLocation()
        timer.invalidate()
    }
    
    func resume() {
        state = .tracking
        manager.startUpdatingLocation()
        startTimerTracking()
    }
    
    func stop() {
        state = .stop
        manager.stopUpdatingLocation()
        timer.invalidate()
        timer = nil
        timingTracking = 0
    }
    
    private func startTimerTracking() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { _ in
            self.timingTracking += 1
        }
    }
    
    
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Пользователь разрешил использовать геопозицию")
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
            self.totalDistance += location.speed
//            self.printData()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        print(">>>>> \(newHeading.trueHeading)")
    }
    
    
    
    private func printData() {
        // Возвращает высоту местоположения.
        // Может быть положительной (над уровнем моря) или отрицательной (ниже уровня моря).
        print("altitude: \(location.altitude)")
        // Возвращает горизонтальную точность местоположения.
        // Значение отрицательное, если горизонтальное местоположение недействительно.
        print("horizontalAccuracy: \(location.horizontalAccuracy)")
        // Возвращает вертикальную точность местоположения.
        // Значение отрицательное, если высота неверна.
        print("verticalAccuracy: \(location.verticalAccuracy)")
        // Возвращает скорость местоположения в м/с.
        // Значение отрицательное, если скорость недействительна.
        print("speed: \(location.speed)")
        // Возвращает курс местоположения в градусах истинного севера.
        // Значение отрицательное, если курс недействителен.
        print("course: \(location.course)")
        // Возвращает точность курса местоположения в градусах.
        // Возвращает отрицательное значение, если курс недействителен.
        print("courseAccuracy: \(location.courseAccuracy)")
        // Возвращает эллипсоидальную высоту местоположения в системе координат WGS 84.
        // Может быть положительным или отрицательным.
        print("ellipsoidalAltitude: \(location.ellipsoidalAltitude)")
        // Возвращает точность скорости местоположения в м/с.
        // Возвращает -1, если значение недействительно.
        print("speedAccuracy: \(location.speedAccuracy)")
        // Возвращает координаты текущего местоположения.
        print("coordinate: \(location.coordinate)")
        print("============================================================================")
    }
}
