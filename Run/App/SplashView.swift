import SwiftUI
import Voyager

struct SplashView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    
    @State private var hasTimeElapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("logo_frame")
                        .renderingMode(.template)
                        .foregroundStyle(.red)
                    Spacer()
                    ProgressView()
                        .tint(.white)
                        .controlSize(.regular)
                    Spacer()
                    Text("viewModel.commentText")
                        .foregroundStyle(.gray)
                        .font(.regular_(size: .size_12))
                }
            }
        }
        .task {
            await delayText()
        }
        .onChange(of: hasTimeElapsed) {
            router.updateRoot(.main)
        }
    }
    
    
    private func delayText() async {
        // Delay - 1 second = 1_000_000_000 nanoseconds
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        hasTimeElapsed = true
    }
}
