//
//  MoneySendVCell.swift
//  VEEZPAY
//
//  Created by DEEPAK on 22/10/23.
//

import UIKit

class MoneySendVCell: UITableViewCell {

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
class CardMoneySendReciver: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 4
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight, .bottomLeft, .topLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          self.layer.mask = mask
    }
    
}

