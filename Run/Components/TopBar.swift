import SwiftUI
import Voyager

struct TopBar: View {
    
    @EnvironmentObject var router: Router<AppRoute>
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .frame(height: 48)
            HStack(spacing: 16, content: {
                HStack {
                    Button(action: {
                        print(1)
                    }) {
                        Image(systemName: "1.square").font(.system(size: 24))
                            .tint(.white)
                    }
                }
                .padding(.leading, 16)
                Spacer()
                HStack {
                    Button(action: {
                        print(2)
                    }) {
                        Image(systemName: "2.square").font(.system(size: 24))
                            .tint(.white)
                    }
                    Button(action: {
                        print(3)
                    }) {
                        Image(systemName: "3.square").font(.system(size: 24))
                            .tint(.white)
                    }
                }
                .padding(.trailing, 16)
            })
            .frame(height: 48)
        }
    }
}


extension TopBar {
    
    @Observable
    class ViewModel {

    }
}


#Preview {
    MainView()
}
