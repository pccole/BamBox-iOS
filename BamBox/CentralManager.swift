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
        if let uuid_array = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] {
            if let cbuuid:CBUUID = uuid_array.first {
                if String(cbuuid) == uuid {
                    peripheral.delegate = self
                }
                
                print(String(cbuuid))
            }
        }
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print(peripheral)
    }
}