//
//  Cups_VC.swift
//  PRINUE
//
//  Created by Razan on 13/06/1443 AH.
//

import UIKit
import Alamofire
import Firebase
import FirebaseStorage

class Cups_VC: UIViewController, UIDocumentPickerDelegate, UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var uploadPDFbutton: UIButton!
    @IBOutlet weak var cupSizeTXT: UITextField!
    @IBOutlet weak var notesTextfield: UITextView!
    @IBOutlet weak var cupView: UIView!
    @IBOutlet weak var orderNameTXT: UITextField!
    @IBOutlet weak var cupTypeTXT: UITextField!
    @IBOutlet weak var qytLBL: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var placeOrderBTN: UIButton!
    
    let db = Firestore.firestore()
    let ref = Storage.storage().reference()
    var pickerView = UIPickerView()
    let cupSizeOption = ["3 oz","7 oz","9 oz","12 oz","16 oz"]
    let cupType = ["Paper","Plastic"]
    
    
    
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
        cupViewSetup()

    }
    
    
    func cupViewSetup() {
        
        notesTextfield.layer.cornerRadius = 20
        notesTextfield.layer.shadowOffset = CGSize (width: -1, height: 1)
        notesTextfield.layer.shadowRadius = 1
        notesTextfield.layer.shadowOpacity = 0.4
        qytLBL.layer.borderColor = CGColor.init(red: 179, green: 224, blue: 184, alpha: 1)
        qytLBL.layer.borderWidth = 0.3
        
    }
    
    func uploadOrderInfo() {
        
        let order = Order(orderName: orderNameTXT.text!, cupsType: cupTypeTXT.text!, cupSize: cupSizeTXT.text!, qyt: qytLBL.text!, price: priceLBL.text!)
        
        let docRef = self.db.collection("orders").document(Auth.auth().currentUser!.uid)
        
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
                    
                        
                    }
                }
            }
    
    
    
    @IBAction func uploadFileOnTapped(_ sender: Any) {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
}
