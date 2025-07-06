import Voyager
import Combine
import SwiftUI

enum AppRouteTabs: Route {
//    case splash
    case main
//    case modalAuthHealthApple
    case newTraning
//    case settingTraning
}

enum AppRoute: Route {
//    case splash
//    case main
    case modalAuthHealthApple
//    case newTraning
    case settingTraning
}


struct ContentView: View {
    
    @StateObject var router = TabRouter<AppRouteTabs>(
        tabs: [.main, .newTraning],
        selected: .main
    )

    var body: some View {
        TabVoyagerView(router: router) { route in
            switch route {
            case .main:
                MainView()
            case .newTraning:
                NewTraningView()
            }
        } tabItem: { route in
            switch route {
            case .main:
                Image(systemName: "house")
            case .newTraning:
                Image(systemName: "figure.run")
            }
        }
        .accentColor(AppTheme.accentColor)
        .onAppear() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(AppTheme.bg_top_bar).withAlphaComponent(0.95)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        
//        NavVoyagerView(router: router) { (route: AppRoute) in
//            switch route {
//            case .splash:
//                SplashView()
//            case .main:
//                MainView()
//            case .modalAuthHealthApple:
//                ModalAuthHealthApple()
//            case .newTraning:
//                NewTraning()
//            case .settingTraning:
//                SettingTraning()
//            }
//        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
