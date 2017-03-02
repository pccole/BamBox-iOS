//
//  PlaylsitViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

protocol ListItem {
	var displayTitle: String { get }
	var displayImage: String { get }
}

typealias PlaylistRunable = ( ( (@escaping ListItemCallback) -> Void) )

class PlaylistViewController: BamBoxViewController {

	var playlistRunable:PlaylistRunable?
	var items = [ListItem]()
	
	lazy var tableView:UITableView = {
		let table = UITableView()
		table.backgroundColor = UIColor.clear
		self.view.addSubview(table)
		table.pinToSuperview()
		return table
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navRouter.isNavigationBarHidden = false
		let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "StartPlaylist"), style: .plain, target: self, action: #selector(createPlaylist))
		navigationController?.navigationItem.rightBarButtonItem = barButtonItem
		guard let runable = playlistRunable else {
			return
		}
		runable({ run in
			do {
				let items = try run()
				self.items = items
				self.tableView.reloadData()
			} catch {
				print(error)
			}
		})
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
	
	init(title:String, playlistRunable:@escaping PlaylistRunable) {
		super.init(nibName: nil, bundle: nil)
		self.title = title
		self.playlistRunable = playlistRunable
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@objc private func createPlaylist() {
		CreateBamBoxViewController.show()
	}

	class func show(title:String, playlistRunable:@escaping PlaylistRunable) {
		let playlist = PlaylistViewController(title: title, playlistRunable: playlistRunable)
		playlist.title = title
		navRouter.pushViewController(playlist)
	}
}

extension PlaylistViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
}

extension PlaylistViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.backgroundColor = UIColor.clear
		guard items.count > 0 else {
			return cell
		}
		cell.textLabel?.text = items[indexPath.row].displayTitle
		cell.textLabel?.textColor = UIColor.white
		return cell
	}
}
