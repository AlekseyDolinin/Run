import SwiftUI
import Voyager

struct TopBarModal: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    var body: some View {
        ZStack {
            AppTheme.bg_top_bar
                .ignoresSafeArea()
                .frame(height: 48)
            HStack(spacing: 16, content: {
                HStack {
                    Button(action: {
                        router.dismiss()
                    }) {
                        Text("Закрыть")
                            .font(.system(size: 16))
                            .tint(.gray)
                    }
                }
                .padding(.leading, 16)
                Spacer()
            })
            .frame(height: 48)
        }
    }
}
#Preview {
    ModalSettingTraning()
}
