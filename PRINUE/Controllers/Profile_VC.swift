//
//  Profile_VC.swift
//  PRINUE
//
//  Created by Razan on 03/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase

class Profile_VC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var firstNameUpdateTextfield: UITextField!
    @IBOutlet weak var lastNameUpdateTextfield: UITextField!
    @IBOutlet weak var emailUpdateTextfield: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    lazy var image : UIImage? = nil
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAvatar()
        DataManager.getUserInfo { user in
            self.fullNameLbl.text = "\(user.firstname ?? "") \(user.lastname ?? "")"
        } onError: { error in
            print(error?.localizedDescription)
        }
        
        
    }
    
    func setUpAvatar() {
        profilePhoto.layer.cornerRadius = 60
        profilePhoto.clipsToBounds = true
        profilePhoto.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profilePhoto.addGestureRecognizer(tapGesture)
        
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else { return }
        let docRef = db.collection("users").document(user.uid)
        docRef.getDocument { snapshot, error in
            let result = snapshot?.data() as! [String: Any]
            do {
                let user = try snapshot?.data(as: User.self)
                let urlString = user?.profilePic ?? ""
                UserDefaults.standard.set(urlString, forKey: "url")
                self.firstNameUpdateTextfield.text = user?.firstname
                self.lastNameUpdateTextfield.text = user?.lastname
                self.emailUpdateTextfield.text = user?.email
                self.profilePhoto.loadFromUrl(urlString)
            }
            catch { print (error.localizedDescription) }
        }
    }
    
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
            profilePhoto.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            profilePhoto.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateOnTapped() {
        
        if let image = profilePhoto.image {
            uploadProfilePhoto(image) { url in
                UserDefaults.standard.set(url, forKey: "url")
                if let user = Auth.auth().currentUser {
                    let docRef = self.db.collection("users").document(user.uid)
                    try? docRef.updateData(["profilePic": url])
                }
            }
        }
        
        if let user = Auth.auth().currentUser {
            let docRef = self.db.collection("users").document(user.uid)
            try? docRef.updateData([
                "firstname" : firstNameUpdateTextfield.text!,
                "lastname" : lastNameUpdateTextfield.text!,
                "email": emailUpdateTextfield.text!
            ])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func uploadProfilePhoto(_ image: UIImage, complition: @escaping ((_ url: String?)-> ())) {
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
    
}



