//
//  File.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth

public class BLE:NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate {
    
    static let singleton = BLE()
    
    let uuid = NSUUID(UUIDString: "3AC92751-8ADE-4DEB-B133-7774E3EE2BFE")
    
    var bluetoothPeripheralManager: CBPeripheralManager!
    var centralManager: CBCentralManager!
    var isBroadcasting = false
    var dataDictionary = [String:AnyObject]()
    
    override init() {
        super.init()
                
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
    }
    
    func switchBroadcastingState() {
        if !isBroadcasting {
            if bluetoothPeripheralManager.state == CBPeripheralManagerState.PoweredOn {
                isBroadcasting = true
                dataDictionary = [CBAdvertisementDataLocalNameKey:"com.BamBox.BamBox2"]
                bluetoothPeripheralManager.startAdvertising(dataDictionary)
            }
        } else {
            bluetoothPeripheralManager.stopAdvertising()
            isBroadcasting = false
        }
    }
    
    func scan() {
        centralManager.scanForPeripheralsWithServices(nil, options: [:])
    }
}


