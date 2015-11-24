//
//  File.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth

public class BLE:NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    static let singleton = BLE()
    
    let uuid = "3AC92751-8ADE-4DEB-B133-7774E3EE2BFE"
    
    var bluetoothPeripheralManager: CBPeripheralManager!
    var centralManager: CBCentralManager!
    var isBroadcasting = false
    var dataDictionary = [String:AnyObject]()
    
    internal var foundDeviceCallBack:(() -> Void)!
    
    override init() {
        super.init()
                
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue(), options:[:])
        
    }
    
    func broadCastPlaylist(playlist:Playlist) {
        if bluetoothPeripheralManager.state == CBPeripheralManagerState.PoweredOn {
            isBroadcasting = true
            
            let myCustomServiceUUID = CBUUID(string: uuid)
            
            let playlist = PlaylistManager.singleton.playlistAtIndex(0)
            let data = playlist.participantToken().dataUsingEncoding(NSUTF8StringEncoding)
            
            let myCharaterisic = CBMutableCharacteristic(type: myCustomServiceUUID,
                properties: CBCharacteristicProperties.Read, value: data, permissions: CBAttributePermissions.Readable)
            
            let myService = CBMutableService(type: myCustomServiceUUID, primary: true)
            myService.characteristics = [myCharaterisic]
            
            dataDictionary = [CBAdvertisementDataLocalNameKey:"BamBox=\(playlist.id)",
                CBAdvertisementDataServiceUUIDsKey: [myService.UUID]]
            
            bluetoothPeripheralManager.addService(myService)
            bluetoothPeripheralManager.startAdvertising(dataDictionary)
        } else {
            print("Bluetooth not powered on")
        }
    }
    
    func stopBroadCasting() {
        bluetoothPeripheralManager.stopAdvertising()
    }
    
    func scan(foundDevice:(() -> Void)!) {
        self.foundDeviceCallBack = foundDevice
        centralManager.scanForPeripheralsWithServices(nil, options: [:])
    }
}


