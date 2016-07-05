//
//  AccountsViewController.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 20/06/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import UIKit
import SideMenu;

class AccountsViewController: UITableViewController {
	let ethstore: EthStore
	var accounts: [Account]
	
	required init?(coder aDecoder: NSCoder) {
		self.ethstore = EthStore(path: NSTemporaryDirectory())
		self.accounts = self.ethstore.accounts()
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return self.accounts.count
		return 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! AccountTableViewCell
//		cell.addressLabel!.text = self.accounts[indexPath.row].asString()
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
//		self.performSegueWithIdentifier(self.rows[indexPath.row], sender: nil)
	}
}

