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
        let defualts = UserDefaults.standard
        userNameGreetingLBL.text = "\(defualts.string(forKey: "userNameKey"))"
        DataManager.getUserInfo {
            
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
    
    
    
//    func checkIfUserLoggedIn() {
//        if Auth.auth().currentUser?.uid == nil {
//            performSelector(inBackground: #selector(self.onTappedLogout), with: nil)
//        } else {
//            let uid = Auth.auth().currentUser?.uid
//            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
//                print(snapshot)
//            } withCancel: { err in
//                print(err)
//            }
//
//        }
//        
//    }
    
    
    
    
    
}
