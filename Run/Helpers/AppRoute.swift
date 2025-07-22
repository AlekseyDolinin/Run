import Voyager
import Combine
import SwiftUI

enum AppRoute: Route {
    case statistic
    case traning
    case settings
    case ready
    case traningDetail
    case connectDevice
    case locationDescriptionView
    case healthKitDescriptionView
    case modalSettingTraning
}


struct TabbarView: View {
    
    @StateObject var router = Router<AppRoute>(root: .statistic)
    
    var body: some View {
        NavVoyagerView(router: router) { (route: AppRoute) in
            switch route {
            case .traning:
                TraningView()
            case .ready:
                ReadyView()
            case .traningDetail:
                TraningDetailView()
            case .connectDevice:
                ConnectDevice()
            case .locationDescriptionView:
                LocationDescriptionView()
            case .healthKitDescriptionView:
                HealthKitDescriptionView()
            case .modalSettingTraning:
                ModalSettingTraning()
            default:
                TabView {
                    StatisticView()
                        .tabItem {
                            Label("Статистика", systemImage: "house")
                        }
                    SelectTypeTraningView()
                        .tabItem {
                            Label("Тренировка", systemImage: "figure.run")
                        }
                    SettingView()
                        .tabItem {
                            Label("Настройки", systemImage: "gear")
                        }
                }
                .tint(AppTheme.accentColor)
                .colorScheme(.dark)
            }
        }
    }
}

#Preview {
    TabbarView()
}
