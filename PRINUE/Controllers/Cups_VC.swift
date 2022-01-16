//
//  Cups_VC.swift
//  PRINUE
//
//  Created by Razan on 13/06/1443 AH.
//

import UIKit
import Alamofire

class Cups_VC: UIViewController, UIDocumentPickerDelegate, UITextViewDelegate {

    @IBOutlet weak var uploadPDFbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
       
    }
    
    fileprivate func uploadDocument(_ file: Data,filename : String,handler : @escaping (String) -> Void) {
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data"
           ]

           AF.upload(
               multipartFormData: { multipartFormData in
                   multipartFormData.append(file, withName: "upload_data" , fileName: filename, mimeType: "application/pdf")
           },
               to: "https://yourserverurl", method: .post , headers: headers)
               .response { response in
                   if let data = response.data{
                       //handle the response however you like
                   }
           }
        
      
        
//        uploadPDFbutton.addAction(for: .touchUpInside) {
//            let importMenu = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
//            importMenu.delegate = self
//            importMenu.modalPresentationStyle = .formSheet
//            self.present(importMenu, animated: true, completion: nil)
//        }
    
       }
    
    
    @IBAction func uploadFileOnTapped(_ sender: Any) {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: [String("kUTTypePDF")], in: .import)
            documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    

    
    
    

   

}
