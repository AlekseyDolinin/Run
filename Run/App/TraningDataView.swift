import SwiftUI
import Voyager

struct TraningDataView: View {
        
    var body: some View {
        ZStack {
            AppTheme.bg_one
            VStack() {
                TopBar()
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        ForEach((0..<5)) { index in
                            Rectangle()
                                .frame(height: 200)
                                .foregroundStyle(AppTheme.bg_plate)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .safeAreaPadding(.top, 72)
    }
}

#Preview {
    TraningDataView()
}
