//
//  CountryTVCell.swift
//  Tivo
//
//  Created by Deepak Vaishnav on 01/02/22.
//

import UIKit

class CountryTVCell: UITableViewCell {
    @IBOutlet weak var flgImage: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
