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
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print(advertisementData)

        print("central manager did discover")

        if let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            if localName.contains("BamBox") {
                let values:[String] = localName.components(separatedBy: "=")
                let playlistID:String = values.last!
                PlaylistManager.singleton.getPlaylistById(Int(playlistID)!, completion: { (bool) -> Void in
                    print("playlist added :D")
                    self.foundDeviceCallBack()
                })
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(peripheral)
    }
}
