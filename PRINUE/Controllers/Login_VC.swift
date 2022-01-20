//
//  Login_VC.swift
//  PRINUE
//
//  Created by Razan on 22/05/1443 AH.
//

import UIKit
import FirebaseAuth


class Login_VC: UIViewController {
    
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginErrorLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        if Auth.auth().currentUser != nil {
            
            guard (storyboard?.instantiateViewController(withIdentifier: "HomeNavigationID") as? HomeNavigation) != nil else { return  }
            
        }
            //        let allProdcts = DataManager.getAllProduct(collectionName: "asdfs")
            //        for pro in allProdcts {
            //            print (pro.Size)
            //        }
            
        }
        
        func setUp() {
            loginErrorLBL.alpha = 0
        }
        
      @IBAction func loginTapped(_ sender: Any) {
            
          let defaults = UserDefaults.standard
            let passowrd = loginPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = loginEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: passowrd) { result, error in
                
                if error != nil {
                    self.loginErrorLBL.text = error!.localizedDescription
                    self.loginErrorLBL.alpha = 1
                }
                else {
                    
                    
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavigationID") as! HomeNavigation
                    
                    defaults.set(true, forKey: "isUserSignedIn")
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
            
        }
        
        
}

