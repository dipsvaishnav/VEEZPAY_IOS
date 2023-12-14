//
//  TransactionHistoryTVCell.swift
//  VEEZPAY
//
//  Created by DEEPAK on 18/11/23.
//

import UIKit

class TransactionHistoryTVCell: UITableViewCell {
    @IBOutlet var viewBackGround: UIView!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblPaidTo: UILabel!
    @IBOutlet var lblMobileNo: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var TransactionType: UIImageView!
    @IBOutlet var lblFrom: UILabel!
    @IBOutlet var lblFromIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
