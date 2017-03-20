//
//  ListView.swift
//  BamBox
//
//  Created by Phil Cole on 3/14/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

typealias ListRunable = ( ( (@escaping ListItemCallback) -> Void) )

protocol ListItem {
	var displayHeader: String { get }
	var displaySubheader: String { get }
	var displayImageURL: URL? { get }
}

protocol ListViewModel: NSObjectProtocol {
	var title:String { get }
	var runable:ListRunable? { get }
	var delegate:ListViewDelegate? { get }
	var dataSource:ListViewDataSource? { get }
	func viewDidLoad(_ vc:UIViewController)
	func registerCell(with tableView:UITableView)
}

extension ListViewModel {
	func registerCell(with tableView:UITableView) {
		let nib = UINib(nibName: ListViewCell.identifier, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: ListViewCell.identifier)
	}
}

protocol ListViewDelegate {
	func listView(_ listView:UITableView, didSelect listItem:ListItem, at indexPath: IndexPath)
}

extension ListViewDelegate {
	func listView(_ listView:UITableView, didSelect listItem:ListItem, at indexPath: IndexPath) {
		listView.deselectRow(at: indexPath, animated: true)
	}
}

protocol ListViewDataSource {
	func listView(_ listView:UITableView, item listItem:ListItem, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	func listView(_ listView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	func numberOfSections(in tableView: UITableView) -> Int
}

extension ListViewDataSource {
	func listView(_ listView:UITableView, item listItem:ListItem, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = listView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else {
			return UITableViewCell()
		}
		cell.configure(for: listItem)
		cell.backgroundColor = UIColor.clear
		return cell
	}
	
	func listView(_ listView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}

