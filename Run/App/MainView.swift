import SwiftUI
import Voyager

struct MainView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .center, spacing: 0) {
                TopBar()
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        ForEach((0..<5)) { index in
                            Rectangle()
                                .frame(height: 200)
                                .foregroundStyle(AppTheme.bg_one)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 140)
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 16)
            }
            .safeAreaPadding(.top, 56)
            ZStack {
                VStack {
                    Spacer()
                    Button(action: {
                        print("START")
                    }) {
                        Text("START")
                            .font(.regular_(size: .size_18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 100)
                    }
                    .background(.blue)
                }
            }
        }
        .ignoresSafeArea()
        .task {
            let status = await Health.shared.ckeckAuthHealthKit()
            switch status {
            case .notDetermined:
                print("AuthHealthKit: not Determined")
                router.present(.modalAuthHealthApple, option: .fullscreenCover)
            case .sharingDenied:
                print("AuthHealthKit: sharing Denied")
            case .sharingAuthorized:
                print("AuthHealthKit: sharing Authorized")
            @unknown default:
                print("Unknown authorization status")
            }
        }
    }
}

#Preview {
    MainView()
}


extension MainView {
    
    @Observable
    class ViewModel {

        
    }
}
