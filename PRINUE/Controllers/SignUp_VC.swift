//
//  SignUp_VC.swift
//  PRINUE
//
//  Created by Razan on 19/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseDatabase

class SignUp_VC: UIViewController {
    @IBOutlet weak var fistNameTextFeild: UITextField!
    @IBOutlet weak var lastNameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var PasswordTextFeild: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var profilePicSignup: UIImageView!
    
    let db = Firestore.firestore()
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFields()
        setUpProfilePic()
        
        
        
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
    
    //    var imageData = Data()
    @IBAction func signUpTapped(_ sender: Any) {
        
        
        let defaults = UserDefaults.standard
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            
            let FistName = fistNameTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let LastName = lastNameTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = emailTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = PasswordTextFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //            let profilePic = profilePicSignup.image
            //            var urlString = String()
            
            
            
            Auth.auth().createUser(withEmail: Email, password: Password) { result, err in
                if err != nil {
                    self.showError("* Error creating user")
                } else {
                    
                    let imgUrl = UserDefaults.standard.string(forKey: "url")
                    let user = User(uid: result!.user.uid, firstname: FistName, lastname: LastName, email: result!.user.email!, profilePic: imgUrl ?? "", isAdmin: false, orders: [])
                    
                    defaults.set(true, forKey: "isUserSignedIn")
                    
                    do {
                        let docRef = self.db.collection("users").document(result!.user.uid)
                        try docRef.setData(from: user)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    self.db.collection("users").document("7NN8s3HlLgP2spPI6XOXodqvAZ83").getDocument { doc, err in
                        if (err == nil) {
                            _ = try! doc?.data(as: User.self)
                        }
                    }
                    
                    
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    func uploadProfilePhoto(_ image: UIImage, _ complition: @escaping ((_ url: String?)-> ())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageSelected = self.image else {
            print("No Photo")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if error == nil {
                print("Faild to upload profile image")
            }
            storageRef.downloadURL { url, error in
                
                guard let url = url, error == nil else { return }
                let urlString = url.absoluteString
                complition(urlString)
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
                
            }
            
        }
        
        
    }
    
    
    func showError(_ massage:String) {
        errorLabel.text = massage
        errorLabel.alpha = 1
    }
    
    
    func transitionToHome() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavigationID") as! HomeNavigation
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func setUpProfilePic() {
        profilePicSignup.layer.cornerRadius = 50
        profilePicSignup.layer.borderWidth = 0.3
        profilePicSignup.layer.borderColor = UIColor.black.cgColor
        profilePicSignup.clipsToBounds = true
        profilePicSignup.clipsToBounds = true
        profilePicSignup.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profilePicSignup.addGestureRecognizer(tapGesture)
        
    }
    //    var urlString = String()
    //
    //    func uploadPhoto(data : Data) {
    //        let uid = Auth.auth().currentUser?.uid
    //        let storageRef = Storage.storage().reference().child("user")
    //        storageRef.child("avatar.png")
    //
    //        storageRef.putData(data, metadata: nil) { metedata, Error in
    //            storageRef.downloadURL { url, Error in
    ////                self.urlString = url.absoluteString
    //                print()
    //            }
    //        }
    //        }
    
    
}







extension SignUp_VC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            profilePicSignup.image = imageSelected
            uploadProfilePhoto(imageSelected) { url in
                //                let docRef = self.db.collection("users").document(Auth.auth().currentUser!.uid)
                //                try? docRef.updateData(["profilePic": url])
                
            }
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            profilePicSignup.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}

