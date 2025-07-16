import SwiftUI
import Voyager

@MainActor
struct ReadyView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var opacity: Double = 1.0
    @State private var nameImage: String = ""
    
    var body: some View {
        ZStack {
            AppTheme.accentColor
                .ignoresSafeArea()
            
            Image(systemName: nameImage).font(.system(size: 300))
                .foregroundStyle(.white)
                .opacity(opacity)
        }
        .onFirstAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        opacity = 1
        nameImage = "1.circle.fill"
        withAnimation(.linear(duration: 0.75)) {
            opacity = 0
        } completion: {
            opacity = 1
            nameImage = "2.circle.fill"
            withAnimation(.linear(duration: 0.75)) {
                opacity = 0
            } completion: {
                opacity = 1
                nameImage = "3.circle.fill"
                withAnimation(.linear(duration: 0.75)) {
                    opacity = 0
                } completion: {
                    dismissScreen()
                }
            }
        }
    }
    
    private func dismissScreen() {
        router.dismiss()
        router.updateRoot(.traning)
    }
}

#Preview {
    ReadyView()
}
