//
//  Cups_VC.swift
//  PRINUE
//
//  Created by Razan on 13/06/1443 AH.
//

import UIKit
import Alamofire

class Cups_VC: UIViewController, UIDocumentPickerDelegate, UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var uploadPDFbutton: UIButton!
    
    @IBOutlet weak var cupSizeTXT: UITextField!
    
    var pickerView = UIPickerView()
    let cupSizeOption = ["3 oz","7 oz","9 oz","12 oz","16 oz"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cupSizeOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cupSizeOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cupSizeTXT.text = cupSizeOption[row]
        cupSizeTXT.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        cupSizeTXT.inputView = pickerView

        
        
        
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
        // TODO: SALIM
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
}
