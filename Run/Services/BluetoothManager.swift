import CoreBluetooth

@Observable
final class BluetoothManager: NSObject {
    
    static let shared = BluetoothManager()
    
    var manager: CBCentralManager!
    
    var devices = Set<CBPeripheral>()
    
    override init() {
        super.init()
        manager = CBCentralManager(
            delegate: self,
            queue: nil
        )
    }
    
    func connectTo(peripheral: CBPeripheral) {
        manager.stopScan()
        manager.connect(
            peripheral,
            options: nil
        )
    }
    
//    private func setupPeripheral(serviceUUID: CBUUID, characteristicUUID: CBUUID) {
//        // Build our service.
//        // Start with the CBMutableCharacteristic.
//        let transferCharacteristic = CBMutableCharacteristic(
//            type: characteristicUUID,
//            properties: [.notify, .writeWithoutResponse],
//            value: nil,
//            permissions: [.readable, .writeable]
//        )
//        // Create a service from the characteristic.
//        let transferService = CBMutableService(type: serviceUUID, primary: true)
//        // Add the characteristic to the service.
//        transferService.characteristics = [transferCharacteristic]
//        // And add it to the peripheral manager.
////        peripheralManager.add(transferService)
//        // Save the characteristic for later.
//        self.transferCharacteristic = transferCharacteristic
//    }
//    
//    var transferCharacteristic: CBMutableCharacteristic!
}


extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn: // Bluetooth включен, можно начинать поиск
            print("poweredOn")
            manager.scanForPeripherals(
                withServices: nil,
                options: nil
            )
        case .poweredOff:
            print("poweredOff")
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        default:
            break
        }
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        if peripheral.name != nil {
            // добавление в список всех найденых BT устройств
            devices.insert(peripheral)
//            print("индикатор уровня принятого сигнала: \(RSSI)")
//            Значения RSSI представлены в виде отрицательных чисел, теоретически максимум равен 0
        }
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didConnect peripheral: CBPeripheral
    ) {
        print("Connected to \(peripheral.name ?? "a device")")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverServices error: Error?
    ) {
        print("!!!!!!!!")
        
//        print(peripheral.discoverServices(nil))
        // peripheral.services - Список открытых услуг периферийного устройства.
        for service in peripheral.services! {
//            print("service: \(service)")
//            print("description: \(service.description)")
//            print("uuid: \(service.uuid)")
//            
//            if let characteristics = service.characteristics {
//                for i in characteristics {
//                    print(i.uuid)
//                    print(i.properties)
//                    print(i.value)
//                    print(i.service)
//                    print(i.descriptors)
//                }
//                print("---------------------")
//            }
//           
//            print("=======================================================================")

            peripheral.discoverCharacteristics(
                nil,
                for: service
            )
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService,
        error: Error?
    ) {
        print("////////")
        for characteristic in service.characteristics! {
//            print("characteristic: \(characteristic)")
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            
//            if characteristic.properties.contains(.write) {
//                let data: Data = // your data here
//                peripheral.writeValue(data, for: characteristic, type: .withResponse)
//            }
        }
    }
    
    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        let data = characteristic.value
        print("data: \(data)")
        let str = String(decoding: data ?? Data(), as: UTF8.self)
        
        print(str)
        // Handle the data as needed
    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: (any Error)?) {
        print("didOpen channel")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("didModifyServices invalidatedServices")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: (any Error)?) {
        print("didReadRSSI RSSI")
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("toSendWriteWithoutResponse peripheral")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        print("didDisconnectPeripheral peripheral")
        
        print("???????")
        print(peripheral.state)
        print(peripheral.name)
        print(peripheral.services)
         // Peripheral is not connected to any central.
        
    }
    
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        print("didUpdateANCSAuthorizationFor peripheral")
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print("connectionEventDidOccur event")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        print("didDisconnectPeripheral peripheral")
    }
}


extension BluetoothManager: CBPeripheralDelegate {
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        print("peripheralDidUpdateName")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        print("didWriteValueFor characteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: (any Error)?) {
        print("didWriteValueFor descriptor")
    }
        
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: (any Error)?) {
        print("didUpdateValueFor descriptor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: (any Error)?) {
        print("didDiscoverDescriptorsFor characteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: (any Error)?) {
        print("didUpdateNotificationStateFor characteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: (any Error)?) {
        print("didDiscoverIncludedServicesFor service")
    }
}
