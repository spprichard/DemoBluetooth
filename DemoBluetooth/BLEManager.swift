//
//  BLEManager.swift
//  DemoBluetooth
//
//  Created by Steven Prichard on 10/2/20.
//  Copyright © 2020 Steven Prichard. All rights reserved.
//

import Foundation
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let advertisedName: String
    let rssi: Int
}


class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    var central: CBCentralManager!
    
    @Published
    var isSwitchedOn: Bool = false
    
    @Published var peripherals = [Peripheral]()
    
    override init() {
        super.init()
        
        self.central = CBCentralManager(delegate: self, queue: nil)
        self.central.delegate = self
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var advertisedName: String
        var name: String
        
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            advertisedName = name
        } else {
            advertisedName = "Unknown"
        }
        
        if let tmpName = peripheral.name {
            name = tmpName
        } else {
            name = "Unknown"
        }
        
        self.peripherals.append(Peripheral(id: peripherals.count, name: name, advertisedName: advertisedName, rssi: RSSI.intValue))
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        } else {
            isSwitchedOn = false
        }
    }
    
    func startScanning() {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        central.stopScan()
    }
    
    func clearDevices() {
        peripherals = []
    }
    
    func removeUnknowns() {
        peripherals = peripherals.filter { $0.name != "Unknown" }
    }
}
