//
//  NearbyService.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation

let nearby = NearbyService()

class NearbyService {
	
	private let messageManager:GNSMessageManager
	private var publication:GNSPublication?
	private var subscription:GNSSubscription?
	
	fileprivate init() {
		messageManager = GNSMessageManager(apiKey: "AIzaSyCYDjvzQhs5eQJch_ODz2Tp5FsH7IZMtAE", paramsBlock: { (params: GNSMessageManagerParams?) in
			guard let params = params else { return }
			params.microphonePermissionErrorHandler = { (hasError: Bool) in
				print("TURN ON YOUR SOUND FUCKER")
			}
			params.bluetoothPowerErrorHandler = { (hasError: Bool) in
				print("BLUETOOTH OR NO GO BRO")
			}
			params.bluetoothPermissionErrorHandler = { (hasError: Bool) in
				print("SEE ABOVE, BITCH")
			}
		})
	}
	
	/// Stops publishing/subscribing.
	func stopScan() {
		subscription = nil
	}
	
	func stopPublish() {
		publication = nil
	}
	
	func scan() {
		messageManager.subscription(messageFoundHandler: { (message:GNSMessage?) in
			guard let message = message else { return }
			let messageString = String(bytes: message.content, encoding: .utf8)
			print("Message found: \(messageString)")
		}, messageLostHandler: { (message:GNSMessage?) in
			guard let message = message else { return }
			let messageString = String(bytes: message.content, encoding: .utf8)
			print("Message lost: \(messageString)")
		}) { (params:GNSSubscriptionParams?) in
			guard let params = params else { return }
			print("Params: \(params)")
		}
	}
	
	/// Toggles the permission state of Nearby.
	func toggleNearbyPermission() {
		GNSPermission.setGranted(!GNSPermission.isGranted())
	}
	
	/// Starts publishing the specified name and scanning for nearby devices that are publishing
	/// their names.
	func publish(name: String) {
		// Publish the name to nearby devices.
		let pubMessage: GNSMessage = GNSMessage(content: name.data(using: .utf8, allowLossyConversion: true))
		publication = messageManager.publication(with: pubMessage)
	}
	
	func sendMessage(message: String) {
		
		
	}
}
