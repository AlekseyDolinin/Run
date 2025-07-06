//import SwiftUI
//import Voyager
//
//struct TopBarModal: View {
//    
//    @EnvironmentObject var router: Router<AppRoute>
//    
//    var onlyBack: Bool
//    
//    var body: some View {
//        ZStack {
//            AppTheme.bg_top_bar
//                .ignoresSafeArea()
//            HStack {
//                Button(action: {
//                    router.dismiss()
//                }) {
//                    Image(systemName: "xmark").font(.system(size: 24))
//                        .tint(.gray)
//                }
//                Spacer()
//                if onlyBack != true {
//                    Button(action: {
//                        print(1)
//                    }) {
//                        Image(systemName: "gearshape").font(.system(size: 24))
//                            .tint(.gray)
//                    }
//                }
//            }
//            .padding(.horizontal, 16)
//        }
//        .frame(height: 48)
//    }
//}
//
//
//#Preview {
//    NewTraning()
//}
