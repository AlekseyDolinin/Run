import SwiftUI
import Voyager

struct ReadyView: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var vm = ViewModel()
        
    var body: some View {
        ZStack {
            AppTheme.accentColor
                .ignoresSafeArea()
            Image(systemName: "1.circle.fill").font(.system(size: vm.sizefontOne))
                .foregroundStyle(.white)
                .opacity(vm.opacityOne)
            Image(systemName: "2.circle.fill").font(.system(size: vm.sizefontTwo))
                .foregroundStyle(.white)
                .opacity(vm.opacityTwo)
            Image(systemName: "3.circle.fill").font(.system(size: vm.sizefontThree))
                .foregroundStyle(.white)
                .opacity(vm.opacityThree)
        }
        .onFirstAppear {
            withAnimation(.linear(duration: 0.75)) {
                vm.sizefontOne = 1000
                vm.opacityOne = 0
            } completion: {
                withAnimation(.linear(duration: 0.75)) {
                    vm.sizefontTwo = 1000
                    vm.opacityTwo = 0
                } completion: {
                    withAnimation(.linear(duration: 0.75)) {
                        vm.sizefontThree = 1000
                        vm.opacityThree = 0
                    } completion: {
                        dismissScreen()
                    }
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


extension ReadyView {
    
    @Observable
    class ViewModel {
        
        var sizefontOne: CGFloat = 1
        var opacityOne: Double = 1
        
        var sizefontTwo: CGFloat = 1
        var opacityTwo: Double = 1
        
        var sizefontThree: CGFloat = 1
        var opacityThree: Double = 1
    }
}
