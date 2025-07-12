import SwiftUI
import CoreLocation
import Voyager

struct TraningDataView: View {
        
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            VStack() {
                
                Text("SPEED")
                    .foregroundStyle(.white)
                Text("\(vm.location.speed)")
                    .font(.custom("MonomaniacOne-Regular", size: 24))
                    .foregroundStyle(.white)
                
                Text("COURSE")
                    .foregroundStyle(.white)
                Text("\(vm.location.course)")
                    .font(.custom("MonomaniacOne-Regular", size: 24))
                    .foregroundStyle(.white)
                
                Text("COORDINATES")
                    .foregroundStyle(.white)
                Text("\(vm.location.coordinate)")
                    .font(.custom("MonomaniacOne-Regular", size: 24))
                    .foregroundStyle(.white)
            }
        }
        .onChange(of: LocationManager.shared.location) { _, location in
            if let location = location {
                vm.location = location
            }
        }
    }
}

#Preview {
    TraningDataView()
}


extension TraningDataView {
    
    @Observable
    class ViewModel {
        
        var location = CLLocation()
        
    }
}
