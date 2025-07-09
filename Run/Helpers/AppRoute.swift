import Voyager
import Combine
import SwiftUI

enum AppRoute: Route {
    case tabbar
    
}

struct ContentView: View {
        
    @StateObject var router = Router<AppRoute>(root: .tabbar)
    
    var body: some View {
        NavVoyagerView(router: router) { (route: AppRoute) in
            switch route {
            case .tabbar:
                TabbarView()
            }
        }
    }
}
