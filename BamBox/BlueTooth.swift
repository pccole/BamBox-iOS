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


public class Bluetooth {
    static let singleton = BLE.singleton
}


internal class BLE:NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate {
    
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
        
        let string = "com.bambox.BamBox"
        let data:NSData = string.dataUsingEncoding(NSStringEncoding.init(Int32))
        
        
        let cbuuid = CBUUID(NSUUID: uuid!)
        var myCharacteristic = CBMutableCharacteristic(type: cbuuid, properties: CBCharacteristicProperties.Read, value: data, permissions: CBAttributePermissions.Readable)
        
        
        
        
//        myCharacteristic =
//            [[CBMutableCharacteristic alloc] initWithType:myCharacteristicUUID
//                properties:CBCharacteristicPropertyRead
//                value:myValue permissions:CBAttributePermissionsReadable];
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

extension BLE {
    internal func centralManagerDidUpdateState(central: CBCentralManager) {
        print(central)
    }
    
    internal func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print(peripheral)
        print(advertisementData)
        print(RSSI)
        print("central manager did discover")
    }
}

extension BLE {
    internal func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        var statusMessage = ""
        
        switch peripheral.state {
        case CBPeripheralManagerState.PoweredOn:
            statusMessage = "Bluetooth Status: Turned On"
            
        case CBPeripheralManagerState.PoweredOff:
            statusMessage = "Bluetooth Status: Turned Off"
            
        case CBPeripheralManagerState.Resetting:
            statusMessage = "Bluetooth Status: Resetting"
            
        case CBPeripheralManagerState.Unauthorized:
            statusMessage = "Bluetooth Status: Not Authorized"
            
        case CBPeripheralManagerState.Unsupported:
            statusMessage = "Bluetooth Status: Not Supported"
            
        default:
            statusMessage = "Bluetooth Status: Unknown"
        }
        
        print(statusMessage)
    }
}