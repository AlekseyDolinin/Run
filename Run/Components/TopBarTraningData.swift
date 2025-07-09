import SwiftUI
import Voyager

struct TopBarTraningData: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    var body: some View {
        ZStack {
            AppTheme.bg_top_bar
                .ignoresSafeArea()
                .frame(height: 48)
            HStack(spacing: 16, content: {
                HStack {
                    Button(action: {
                        print(1)
                    }) {
                        Image(systemName: "1.square").font(.system(size: 24))
                            .tint(.gray)
                    }
                }
                .padding(.leading, 16)
                Spacer()
                HStack {
                    Button(action: {
                        print(2)
                    }) {
                        Image(systemName: "2.square").font(.system(size: 24))
                            .tint(.gray)
                    }
                    Button(action: {
                        print(3)
                    }) {
                        Image(systemName: "3.square").font(.system(size: 24))
                            .tint(.gray)
                    }
                }
                .padding(.trailing, 16)
            })
            .frame(height: 48)
        }
    }
}
