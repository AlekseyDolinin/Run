import SwiftUI
import Voyager
import CoreLocation

struct HealthKitDescriptionView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
        
    var body: some View {
        ZStack {
            Color.purple
                .opacity(0.8)
            VStack(alignment: .leading, spacing: 24) {
                Text("Тест про то зачем надо разрешить использовать HealthKit")
                    .foregroundStyle(.white)
                Button(action: {
                    router.dismiss()
                    HealthKitManager.shared.getHealthKitPermission()
                }) {
                    Text("Ok")
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 64)
                }
            }
            .safeAreaPadding(.horizontal)
            .safeAreaPadding(.bottom, 64)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HealthKitDescriptionView()
}


extension HealthKitDescriptionView {
    
    @Observable
    class ViewModel {
        
        
    }
}
