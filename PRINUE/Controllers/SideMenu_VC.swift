//
//  SideMenu_VC.swift
//  PRINUE
//
//  Created by Razan on 30/05/1443 AH.
//

import UIKit
import FirebaseAuth


enum SideMenuOption: Int {
    case Profile = 1
    case Orders
    case Contact
}

protocol SideMenuDelegate {
    func didSelectMenu(option: SideMenuOption)
}

class SideMenu_VC: UIViewController {
    
    
    @IBOutlet weak var userNameGreetingLBL: NSLayoutConstraint!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var logoutBottun: UIButton!
    
    var delegate: SideMenuDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()
    }
    
    private func setUpSideMenu() {
        BGView.layer.cornerRadius = 40
        BGView.clipsToBounds = false
       BGView.layer.shadowOffset = CGSize (width: -1, height: 1)
        BGView.layer.shadowRadius = 1
        BGView.layer.shadowOpacity = 0.4
    }
    
    @IBAction func profileButton(_ sender: Any) {
       
    }
    
    @IBAction func contactButton(_ sender: Any) {
        
        delegate.didSelectMenu(option: .Contact)
//        _ = storyboard?.instantiateViewController(withIdentifier: "ContactID") as! Contact_VC
//        guard let vc = storyboard?.instantiateViewController(identifier: "ContactID") else { return }
//        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalPresentationStyle = .currentContext
//        show(vc, sender: self)
       
    }
    
    @IBAction func yourOrderButton(_ sender: Any) {
        
    }
    
    
    @IBAction func onTappedLogout(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
//            let loginView = LoginView()
            let transfer =  UIApplication.shared.windows.first
            let storybord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = storybord.instantiateViewController(withIdentifier: "LoginNavigationController") as! LoginNavigationController
            transfer?.makeKeyAndVisible()
            transfer?.rootViewController = vc
            
        }
        catch let err
        {
            print(err)
        }
         
        }

    
    
    

}