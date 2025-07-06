import SwiftUI
import Voyager
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject var router = Router<AppRoute>(root: .splash)
    
    var body: some View {
        NavVoyagerView(router: router) { (route: AppRoute) in
            switch route {
            case .splash:
                SplashView()
            case .main:
                MainView()
            case .modalAuthHealthApple:
                ModalAuthHealthApple()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
