import SwiftUI
import MapKit

struct TraningMapView: View {
        
    @State private var hasTimeElapsed = false
    
    var body: some View {
        ZStack {
            AppTheme.accentColor
            
            Map(interactionModes: [])
                .mapStyle(.imagery)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height - 200)
        }
//        .ignoresSafeArea()
    }
}

#Preview {
    NewTraningView()
}
