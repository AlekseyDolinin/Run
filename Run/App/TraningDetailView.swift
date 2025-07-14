import SwiftUI
import Voyager

struct TraningDetailView: View {
        
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            VStack() {
                TopBarOnlyBack()
                ScrollView {
                    Rectangle()
                        .frame(height: 400)
                        .foregroundStyle(AppTheme.bg_plate)
                        .cornerRadius(16)
                }
                .scrollIndicators(.hidden)
                .safeAreaPadding()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    TraningDetailView()
}
