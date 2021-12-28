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
        
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        loginErrorLBL.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let passowrd = loginPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = loginEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: passowrd) { result, error in
            
            if error != nil {
                self.loginErrorLBL.text = error!.localizedDescription
                self.loginErrorLBL.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
    
}
