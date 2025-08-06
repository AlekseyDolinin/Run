
final class TimeConverter {
    
    static let shared = TimeConverter()
    
    func convertSecondToHHMMSS(_ second: Int) -> String {
        if second == 0 {
            return "00:00:00"
        } else {
            let hours = String(format: "%02d", second / 3600)
            let minutes = String(format: "%02d", (second % 3600) / 60)
            let seconds = String(format: "%02d", (second % 3600) % 60)
            return "\(hours):\(minutes):\(seconds)"
        }
    }
}
