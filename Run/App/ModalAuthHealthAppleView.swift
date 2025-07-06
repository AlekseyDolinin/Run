import SwiftUI
import Voyager

struct ModalAuthHealthAppleView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
        
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.bg_one
                    .ignoresSafeArea()
                VStack {
                    Image("Apple_Health_badge_US-UK_blk_sRGB")
                    Spacer()
                    Button(action: {
                        print("Разрешить")
//                        HealthKitService.getInstance().authorize { bool in
//                            print("bool: \(bool)")
//                            router.dismiss()
//                        }
//                        Health.shared.authRequest()
//                        router.dismiss()
                        
                    }) {
                        Text("Разрешить")
                            .font(.medium(size: .size_16))
                            .frame(maxWidth: .infinity, minHeight: 48)
                    }
                    .foregroundStyle(.black)
                    .background(.blue)
                    .cornerRadius(16)
                }
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    ModalAuthHealthAppleView()
}
