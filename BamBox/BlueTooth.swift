//
//  File.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

public class BLE:NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate {
    
    static let singleton = BLE()
    
    let uuid = NSUUID(UUIDString: "3AC92751-8ADE-4DEB-B133-7774E3EE2BFE")
    let major = "1"
    
    var beaconRegion: CLBeaconRegion!
    var bluetoothPeripheralManager: CBPeripheralManager!
    var centralManager: CBCentralManager!
    var isBroadcasting = false
    var dataDictionary = NSDictionary()
    
    override init() {
        super.init()
                
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
    }
    
    func switchBroadcastingState() {
        if !isBroadcasting {
            if bluetoothPeripheralManager.state == CBPeripheralManagerState.PoweredOn {
                let major: CLBeaconMajorValue = UInt16(1)
                let minor: CLBeaconMinorValue = UInt16(1)
                beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: "com.bambox.Bambox")
                isBroadcasting = true
                dataDictionary = beaconRegion.peripheralDataWithMeasuredPower(nil)
                bluetoothPeripheralManager.startAdvertising(dataDictionary as? [String : AnyObject])
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


