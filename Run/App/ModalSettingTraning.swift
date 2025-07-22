import SwiftUI
import Voyager

struct ModalSettingTraning: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            VStack() {
                TopBarModal()
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        Text("ModalSettingTraning")
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 64)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    ModalSettingTraning()
}


extension ModalSettingTraning {
    
    @Observable
    class ViewModel {
        
    }
}
