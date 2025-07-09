import SwiftUI
import Voyager

struct TraningDataView: View {
        
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            VStack() {
                
                Text("Data")
                    .foregroundStyle(.white)
                Text("Data")
                    .foregroundStyle(.white)
                Text("Data")
                    .foregroundStyle(.white)
                Text("Data")
                    .foregroundStyle(.white)
                Text("Data")
                    .foregroundStyle(.white)
                
                
//                TopBarTraningData()
//                ScrollView {
//                    VStack(alignment: .center, spacing: 16) {
//                        ForEach((0..<5)) { index in
//                            Rectangle()
//                                .frame(height: 200)
//                                .foregroundStyle(AppTheme.bg_plate)
//                        }
//                    }
//                }
//                .scrollIndicators(.hidden)
            }
        }
//        .safeAreaPadding(.top, 74)
    }
}

#Preview {
    TraningDataView()
}
