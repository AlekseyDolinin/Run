import SwiftUI
import Voyager

struct SettingView: View {
        
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            ScrollView {
                Text("SettingView")
                    .foregroundStyle(.white)
                Text("SettingView")
                    .foregroundStyle(.white)
                Text("SettingView")
                    .foregroundStyle(.white)
                Text("SettingView")
                    .foregroundStyle(.white)
                Text("SettingView")
                    .foregroundStyle(.white)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SettingView()
}
