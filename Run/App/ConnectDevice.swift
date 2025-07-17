import SwiftUI
import CoreBluetooth
import Voyager

struct ConnectDevice: View {
        
    @State private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            AppTheme.bg_one
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center, spacing: 16) {                    
                    ForEach(vm.getDevices(), id: \.self) { peripheral in
                        Button(action: {
                            BluetoothManager.shared.manager.connect(peripheral)
                        }) {
                            Text(peripheral.name ?? "---")
                                .foregroundStyle(.white)
                                .frame( width: 200, height: 100)
                        }
                        .background(AppTheme.accentColor)
                        .cornerRadius(16)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarHidden(true)
        .onFirstAppear {
            vm.bluetoothManagerInit()
        }
    }
}

#Preview {
    ConnectDevice()
}


extension ConnectDevice {
    
    @Observable
    class ViewModel {
        
        func bluetoothManagerInit() {
            print("BluetoothManager init")
            _ = BluetoothManager.init()
        }

        func getDevices() -> [CBPeripheral] {
            let array = Array(BluetoothManager.shared.devices)
            return array
        }
    }
}
