//
//  AccountTableViewCell.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 22/06/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
