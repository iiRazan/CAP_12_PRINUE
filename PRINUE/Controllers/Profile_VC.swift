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
    @IBOutlet weak var avatar: UIImageView!
    
    var image : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAvatar()
        
    }
    
    func setUpAvatar() {
        profilePhoto.layer.cornerRadius = 60
        avatar.layer.cornerRadius = 65
        profilePhoto.clipsToBounds = true
        profilePhoto.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profilePhoto.addGestureRecognizer(tapGesture)
        
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
    
    func updateOnTapped() {
        
        guard let imageSelected = self.image else {
            print("No Photo")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
        
//        if let authData = authDataResult {
//            print(authData.user.uid)
//            let dirt: Dictionary<String, Any> = [
//                "uid": authData.user.uid,
//                "email": authData.user.email,
//                "ProfileImageUrl": ""
//            ]
            
            let storageRef = Storage.storage().reference(forURL: "gs://prinue-95b91.appspot.com")
//            let storageProfileRef = storageRef.child("Profile").child(authData.user.uid)
            
        }
        
       
        
        
        
        
        
        
        
        
        
    }
    
    
//    @IBAction func editBtn(_ sender: Any) {
//
//        let imgData: NSData = NSData(data: (self.img_Photo?.image)!.jpegData(compressionQuality: 0.5)!)
//        let _:NSData = NSData(data:((self.img_Photo?.image)!).pngData()!)
//        self.uploadProfileImageToFirebase(data: imgData)
//    }
//
//
//
//    func uploadProfileImageToFirebase(data:NSData){
//        let randomPic = randomString(length: 10)
//        let storageRef = Storage.storage().reference().child("Pictures").child("\(value(forKey: "UserUID") ?? randomPic).jpg")
//        if data != nil {
//            storageRef.putData(data as Data, metadata: nil, completion: { (metadata, error) in
//                if(error != nil){
//                    print(error)
//                    return
//                }
//                guard let userID = Auth.auth().currentUser?.uid else {
//                    return
//                }
//                // Fetch the download URL
//                storageRef.downloadURL { url, error in
//                    if let error = error {
//                        // Handle any errors
//                        if(error != nil){
//                            print(error)
//                            return
//                        }
//                    } else {
//                        // Get the download URL for 'images/stars.jpg'
//
//                        let urlStr:String = (url?.absoluteString) ?? ""
//                        let values = ["photo_url": urlStr]
//                        self.registerUserIntoDatabaseWithUID(uid: userID, values: values as [String : AnyObject])
//                    }
//                }
//            })
//        }
//
//    }
//
//    func registerUserIntoDatabaseWithUID(uid:String, values:[String:AnyObject]){
//        let ref = Database.database().reference(fromURL: "https://domain.firebaseio.com/")
//        let usersReference = ref.child("users").child((Auth.auth().currentUser?.uid)!)
//
//        usersReference.updateChildValues(values) { (error, ref) in
//            if(error != nil){
//                print(error)
//                return
//            }
//            self.parentVC?.dismiss(animated: true, completion: nil)
//        }
//
//    }




