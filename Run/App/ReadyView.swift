import SwiftUI
import Voyager
import Lottie

@MainActor
struct ReadyView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var showStartAnimation = false
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            if showStartAnimation == true {
                LottieView(animation: .named("3_2_1_go.json"))
                    .resizable()
                    .playing(loopMode: .playOnce)
                    .frame(height: 600)
            }
        }
        .onFirstAppear {
            delayShowAnimation()
            delayHideView()
        }
    }
    
    private func delayShowAnimation() {
        Task(priority: .userInitiated) {
            try? await Task.sleep(nanoseconds: 400_000_000)
            showStartAnimation = true
        }
    }
    
    private func delayHideView() {
        Task(priority: .userInitiated) {
            try? await Task.sleep(nanoseconds: 3_500_000_000)
            router.dismiss()
            router.updateRoot(.traning)
        }
    }
}

#Preview {
    ReadyView()
}
