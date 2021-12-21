//
//  LoginView.swift
//  PRINUE
//
//  Created by Razan on 16/05/1443 AH.
//

import UIKit

class LoginView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup() {
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.4
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
