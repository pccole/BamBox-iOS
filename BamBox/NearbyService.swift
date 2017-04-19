//
//  NearbyService.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation


enum NearbyMessageType: CustomStringConvertible {
	case playlist
	
	var description: String {
		switch self {
		case .playlist:
			return "Playlist"
		}
	}
	
	init?(string:String) {
		switch string.lowercased() {
		case "playlist":
			self = .playlist
		default:
			return nil
		}
	}
}

protocol NearbyMessageProtocol {
	func refresh(with messages:[GNSMessage])
}

protocol NearbyPlaylistProtocol {
	func didRetrive(_ playlist:SPTPartialPlaylist)
}

let nearby = NearbyService()

class NearbyService {
	
	private let messageManager:GNSMessageManager
	private var publication:GNSPublication?
	private var subscription:GNSSubscription?
	private let apiKey = "AIzaSyBSrHYi4UsmtGE_q7q3Ayebu9TegtQWh_0"
	private var messages = [GNSMessage]()
	
	private var _isClient:Bool = false
	private var _isBroadCaster:Bool = false
	
	var isClient:Bool {
		get {
			return _isClient
		}
		set {
			_isClient = newValue
			_isBroadCaster = !newValue
		}
	}
	var isBroadCaster:Bool {
		get {
			return _isBroadCaster
		}
		set {
			_isBroadCaster = newValue
			_isClient = !newValue
		}
	}
	
	var messageDelegate:NearbyMessageProtocol?
	var playlistDelegate:NearbyPlaylistProtocol?
	
	fileprivate init() {
		messageManager = GNSMessageManager(apiKey: apiKey, paramsBlock: { (params: GNSMessageManagerParams?) in
			guard let params = params else { return }
			
			// This is called when microphone permission is enabled or disabled by the user.
			params.microphonePermissionErrorHandler = { hasError in
				if (hasError) {
					print("Nearby works better if microphone use is allowed")
				}
			}
			// This is called when Bluetooth permission is enabled or disabled by the user.
			params.bluetoothPermissionErrorHandler = { hasError in
				if (hasError) {
					print("Nearby works better if Bluetooth use is allowed")
				}
			}
			// This is called when Bluetooth is powered on or off by the user.
			params.bluetoothPowerErrorHandler = { hasError in
				if (hasError) {
					print("Nearby works better if Bluetooth is turned on")
				}
			}
		})
		#if DEBUG
			GNSMessageManager.setDebugLoggingEnabled(true)
		#endif
	}
	
	func reset() {
		_isBroadCaster = false
		_isClient = false
	}
	
	/// Stops publishing/subscribing.
	func stopScan() {
		subscription = nil
	}
	
	func stopPublish() {
		publication = nil
	}
	
	func scan() {
		subscription = messageManager.subscription(messageFoundHandler: { (message:GNSMessage?) in
			guard let m = message else { return }
			self.nearbyMessageFound(m)
		}, messageLostHandler: { (message:GNSMessage?) in
			guard let m = message else { return }
			self.nearbyMessageLost(m)
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
	func publish(name: String, type:String) {
		// Publish the name to nearby devices.
		let pubMessage: GNSMessage = GNSMessage(content: name.data(using: .utf8, allowLossyConversion: true), type: type)
		publication = messageManager.publication(with: pubMessage)
	}
	
	private func nearbyMessageFound(_ message:GNSMessage) {
		guard let messageString = String(bytes: message.content, encoding: .utf8) else { return }
		print("Message found: \(messageString)")
		print("Message Type: \(message.type)")
		guard let messageType = message.type, let nearbyMessageType = NearbyMessageType(string: messageType) else {
			return
		}
		messages.append(message)
		switch nearbyMessageType {
		case .playlist:
			sptService.getPlaylist(withURI: messageString, callback: { (playlist:SPTPartialPlaylist) in
				self.playlistDelegate?.didRetrive(playlist)
			})
		}
		messageDelegate?.refresh(with: messages)
	}
	
	private func nearbyMessageLost(_ message:GNSMessage) {
		messages = messages.filter { $0 === message }
	}
}
