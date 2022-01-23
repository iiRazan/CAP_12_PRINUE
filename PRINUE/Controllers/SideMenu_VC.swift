//
//  SideMenu_VC.swift
//  PRINUE
//
//  Created by Razan on 30/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


enum SideMenuOption: Int {
    case Profile = 1
    case Orders
    case Contact
}

protocol SideMenuDelegate {
    func didSelectMenu(option: SideMenuOption)
}

class SideMenu_VC: UIViewController {
    
    
    @IBOutlet weak var userNameGreetingLBL: UILabel!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var logoutBottun: UIButton!
    
    
    var delegate: SideMenuDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()
        DataManager.getUserInfo { user in
            self.userNameGreetingLBL.text = "\(user.firstname ?? "") \(user.lastname ?? "")"
        } onError: { error in
            print(error?.localizedDescription)
        }
        
    }
    
    
    private func setUpSideMenu() {
        BGView.layer.cornerRadius = 40
        BGView.clipsToBounds = false
        BGView.layer.shadowOffset = CGSize (width: -1, height: 1)
        BGView.layer.shadowRadius = 1
        BGView.layer.shadowOpacity = 0.4
    }
    
    @IBAction func profileButton(_ sender: Any) {
        delegate.didSelectMenu(option: .Profile)
        
    }
    
    @IBAction func contactButton(_ sender: Any) {
        delegate.didSelectMenu(option: .Contact)
        
    }
    
    @IBAction func yourOrderButton(_ sender: Any) {
        delegate.didSelectMenu(option: .Orders)
        
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
