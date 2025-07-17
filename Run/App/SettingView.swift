import SwiftUI
import Voyager

struct SettingView: View {
        
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {
                        router.present(.connectDevice)
                    }) {
                        Text("connectDevice")
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 64)
                    }
                    .background(AppTheme.accentColor)
                    .cornerRadius(16)
                    
                    Button(action: {
//                        BluetoothManager.shared.startScaning()
                    }) {
                        Text("CHECK PAIR WATCH DEVICE")
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 64)
                    }
                    .background(AppTheme.accentColor)
                    .cornerRadius(16)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SettingView()
}


extension SettingView {
    
    @Observable
    class ViewModel {
        
    }
}
