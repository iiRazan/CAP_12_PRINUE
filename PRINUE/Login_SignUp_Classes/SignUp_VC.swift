//
//  SignUp_VC.swift
//  PRINUE
//
//  Created by Razan on 19/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUp_VC: UIViewController {
    @IBOutlet weak var fistNameTextFeild: UITextField!
    @IBOutlet weak var lastNameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var PasswordTextFeild: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFields()
        
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        if fistNameTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || lastNameTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || emailTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || PasswordTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "* Please fill in all fields"
        }
        return nil
    }
    
    func setUpFields() {
        errorLabel.alpha = 0
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            
            let FistName = fistNameTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let LastName = lastNameTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = emailTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = PasswordTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: Email, password: Password) { result, err in
                if err != nil {
                    self.showError("* Error creating user")
                } else {
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName": FistName, "lastName": LastName, "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            self.showError("* Can't save user data")
                        }
                    }
                    
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    func showError(_ massage:String) {
        errorLabel.text = massage
        errorLabel.alpha = 1
    }
    
    
    func transitionToHome() {
        
    }
    
    
}

