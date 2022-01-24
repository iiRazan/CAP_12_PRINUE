//
//  OrderTVC.swift
//  PRINUE
//
//  Created by Razan on 21/06/1443 AH.
//

import UIKit

class OrderTVC: UITableViewCell {

    @IBOutlet weak var statusBTN: UIButton!
    @IBOutlet weak var orderNameLBL: UILabel!
    @IBOutlet weak var orderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
