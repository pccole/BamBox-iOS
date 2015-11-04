//
//  CentralManager.swift
//  BamBox
//
//  Created by Phil Cole on 10/16/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth

extension BLE {
    public func centralManagerDidUpdateState(central: CBCentralManager) {
        print(central)
    }
    
    public func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print(peripheral)
        print(advertisementData)
        print(RSSI)
        print("central manager did discover")
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print(peripheral)
    }
}