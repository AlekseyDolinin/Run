import Voyager
import Combine
import SwiftUI

struct TabbarView: View {
        
    var body: some View {
        TabView {
            StatisticView()
            .tabItem {
                Label("Статистика", systemImage: "house")
            }
            TraningView()
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

#Preview {
    TabbarView()
}
