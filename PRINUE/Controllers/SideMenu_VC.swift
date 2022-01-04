//
//  SideMenu_VC.swift
//  PRINUE
//
//  Created by Razan on 30/05/1443 AH.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func hideSideMenuView()
}
class SideMenu_VC: UIViewController {
    
    
    var delegate: SideMenuViewControllerDelegate?
    @IBOutlet weak var userNameGreetingLBL: NSLayoutConstraint!
    @IBOutlet weak var BGView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()

        // Do any additional setup after loading the view.
    }
    
    private func setUpSideMenu() {
        BGView.layer.cornerRadius = 40
        BGView.clipsToBounds = false
       BGView.layer.shadowOffset = CGSize (width: -1, height: 1)
        BGView.layer.shadowRadius = 1
        BGView.layer.shadowOpacity = 0.25
    }
    
    @IBAction func profileButton(_ sender: Any) {
        self.delegate?.hideSideMenuView()
    }
    

}
