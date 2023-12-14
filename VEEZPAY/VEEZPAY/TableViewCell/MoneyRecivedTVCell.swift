//
//  MoneyRecivedTVCell.swift
//  VEEZPAY
//
//  Created by DEEPAK on 22/10/23.
//

import UIKit

class MoneyRecivedTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
@IBDesignable
class CardRecivedReciver: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 4
    override func layoutSubviews() {
        //let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight, .bottomLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          self.layer.mask = mask
    }
    
}
