import StoreKit

final class RateManager {
    
    static let shared = RateManager()
    
    func incrementCount() {
        let lounchCount = UserDefaults.standard.integer(forKey: .runCount)
        UserDefaults.standard.set(lounchCount + 1, forKey: .runCount)
        if lounchCount == 15 {
            showRateController()
        }
    }
    
    private func showRateController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                DispatchQueue.main.async {
                    AppStore.requestReview(in: scene)
                }
            }
        }
    }
}

extension String {
    static let runCount = "runCount"
}
