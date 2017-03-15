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

protocol ListTableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

typealias ListRunable = ( ( (@escaping ListItemCallback) -> Void) )

class ListViewController: BamBoxViewController {

	fileprivate var playlistRunable:ListRunable?
	fileprivate var items = [ListItem]()
	fileprivate var cellIdentifier:String?
	
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
		navRouter.viewController.navigationItem.rightBarButtonItem = barButtonItem
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
		tableView.estimatedRowHeight = 60
		tableView.rowHeight = UITableViewAutomaticDimension
		guard let id = cellIdentifier else {
			return
		}
		let nib = UINib(nibName: id, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: id)
    }
	
	init(title:String, cellIdentifier:String, playlistRunable:@escaping ListRunable) {
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

	class func show(title:String, cellIdentifier:String, playlistRunable:@escaping ListRunable) {
		let playlist = ListViewController(title: title, cellIdentifier: cellIdentifier, playlistRunable: playlistRunable)
		playlist.title = title
		navRouter.pushViewController(playlist)
	}
}

extension ListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	
	}
}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let id = cellIdentifier, let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? PlaylistTableViewCell else {
			return UITableViewCell()
		}
		cell.backgroundColor = UIColor.clear
		guard items.count > 0 else {
			return cell
		}
		cell.configure(for: items[indexPath.row] as! SPTPartialPlaylist)
		return cell
	}
}
