import SwiftUI
import Voyager

struct SettingTraning: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    @State private var hasTimeElapsed = false
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
            VStack(alignment: .center, spacing: 0) {
                TopBarModal(onlyBack: true)
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        Rectangle()
                            .frame(height: 200)
                            .foregroundStyle(AppTheme.bg_plate)

                    }
                    .padding(.top, 16)
                    .padding(.bottom, 140)
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 16)
            }
            .safeAreaPadding(.top, 56)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingTraning()
}
