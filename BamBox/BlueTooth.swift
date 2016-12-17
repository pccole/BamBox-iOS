//
//  File.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLE:NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    static let singleton = BLE()
    
    let uuid = "3AC92751-8ADE-4DEB-B133-7774E3EE2BFE"
    
    var bluetoothPeripheralManager: CBPeripheralManager!
    var centralManager: CBCentralManager!
    var isBroadcasting = false
    var dataDictionary = [String:AnyObject]()
    
    internal var foundDeviceCallBack:(() -> Void)!
    
    override init() {
        super.init()
                
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.main, options:[:])
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main, options:[:])
        
    }
    
    func broadCastPlaylist(_ playlist:Playlist) {
        if bluetoothPeripheralManager.state == CBPeripheralManagerState.poweredOn {
            isBroadcasting = true
            
            let myCustomServiceUUID = CBUUID(string: uuid)
            
            let playlist = PlaylistManager.singleton.playlistAtIndex(0)
            let data = playlist.participantToken().data(using: String.Encoding.utf8)
            
            let myCharaterisic = CBMutableCharacteristic(type: myCustomServiceUUID,
                properties: CBCharacteristicProperties.read, value: data, permissions: CBAttributePermissions.readable)
            
            let myService = CBMutableService(type: myCustomServiceUUID, primary: true)
            myService.characteristics = [myCharaterisic]
            
            dataDictionary = [CBAdvertisementDataLocalNameKey:"BamBox=\(playlist.id)",
                CBAdvertisementDataServiceUUIDsKey: [myService.uuid]]
            
            bluetoothPeripheralManager.add(myService)
            bluetoothPeripheralManager.startAdvertising(dataDictionary)
        } else {
            print("Bluetooth not powered on")
        }
    }
    
    func stopBroadCasting() {
        bluetoothPeripheralManager.stopAdvertising()
    }
    
    func scan(_ foundDevice:(() -> Void)!) {
        self.foundDeviceCallBack = foundDevice
        centralManager.scanForPeripherals(withServices: nil, options: [:])
    }
}


