import SwiftUI
import CoreLocation
import UIKit

struct MapView: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> UIViewController {
        return TraningMapVC()
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) { }
}
