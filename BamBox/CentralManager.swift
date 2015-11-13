//
//  CentralManager.swift
//  BamBox
//
//  Created by Phil Cole on 10/16/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import CoreBluetooth
import SwiftyJSON

extension BLE {
    public func centralManagerDidUpdateState(central: CBCentralManager) {
        print(central)
    }
    
    public func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {

        print(advertisementData)

        print("central manager did discover")

        if let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            if localName.containsString("BamBox") {
                let values:[String] = localName.componentsSeparatedByString("=")
                let playlistID:String = values.last!
                PlaylistManager.singleton.getPlaylistById(Int(playlistID)!, completion: { (bool) -> Void in
                    print("playlist added :D")
                    self.foundDeviceCallBack()
                })
            }
        }
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print(peripheral)
    }
}