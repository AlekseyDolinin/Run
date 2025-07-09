import CoreMotion

final class MotionManager: NSObject {
    
    static let shared = MotionManager()
    
    var manager: CMMotionManager!
    
    override init() {
        super.init()
        manager = CMMotionManager()
        manager.deviceMotionUpdateInterval = 1
        manager.startDeviceMotionUpdates()
    }
}
