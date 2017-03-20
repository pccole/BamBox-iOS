//
//  PlaylsitViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit
import Foundation


class ListViewController: BamBoxViewController {

	fileprivate var items = [ListItem]()
	fileprivate var viewModel:ListViewModel?
	
	lazy var tableView:UITableView = {
		let table = UITableView()
		self.view.addSubview(table)
		table.pinToSuperview()
		return table
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navRouter.isNavigationBarHidden = false
		viewModel?.viewDidLoad(self)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.separatorStyle = UITableViewCellSeparatorStyle.none
		tableView.backgroundColor = UIColor.clear
		title = viewModel?.title
		viewModel?.runable? { (run:() throws -> [ListItem]) in
			do {
				let items = try run()
				self.items = items
				self.tableView.reloadData()
			} catch {
				print(error)
			}
		}
		viewModel?.registerCell(with: tableView)
    }
	
	init(viewModel:ListViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@objc private func createPlaylist() {
		CreateBamBoxViewController.show()
	}

	class func show(viewModel:ListViewModel) {
		let list = ListViewController(viewModel: viewModel)
		navRouter.pushViewController(list)
	}
}

extension ListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel?.delegate?.listView(tableView, didSelect: items[indexPath.row], at: indexPath)
	}
}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard items.count > 0,
			let cell = viewModel?.dataSource?.listView(tableView, item: items[indexPath.row], cellForRowAt: indexPath) else {
			let cell = UITableViewCell()
			cell.textLabel?.text = "Empty Playlist"
			return cell
		}
		return cell
	}
}
