import SwiftUI
import Voyager

struct MainView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
    
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
                    .padding(.top, 16)
                    .padding(.bottom, 140)
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 8)
            }
            .safeAreaPadding(.top, 56)
//            ZStack {
//                VStack {
//                    Spacer()
//                    Button(action: {
//                        print("START")
////                        router.present(.newTraning, option: .fullscreenCover)
//                    }) {
//                        Text("Новая тренировка")
//                            .font(.medium(size: .size_16))
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity, minHeight: 56)
//                    }
//                    .foregroundStyle(.black)
//                    .background(.blue)
//                    .cornerRadius(16)
//                }
//            }
//            .padding(.bottom, 32)
//            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
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
