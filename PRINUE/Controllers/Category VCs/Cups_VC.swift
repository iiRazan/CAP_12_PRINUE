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
    var sizePickerView = UIPickerView()
    var typePickerView = UIPickerView()
    let cupSizeOption = ["3 oz","7 oz","9 oz","12 oz","16 oz"]
    let cupType = ["Paper","Plastic"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return cupSizeOption.count
        case 2:
            return cupType.count
        default:
            return 1
        }
                    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return cupSizeOption[row]
        case 2:
            return cupType[row]
        default:
            return "Not Found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            cupSizeTXT.text = cupSizeOption[row]
            cupSizeTXT.resignFirstResponder()
        case 2:
            cupTypeTXT.text = cupType[row]
            cupTypeTXT.resignFirstResponder()
        default:
            return
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        typePickerView.dataSource = self
        typePickerView.delegate = self
        cupSizeTXT.inputView = sizePickerView
        cupTypeTXT.inputView = typePickerView
        
        sizePickerView.tag = 1
        typePickerView.tag = 2
        
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
        
       
        
        let userRef = self.db.collection("users").document(Auth.auth().currentUser!.uid)
        
        let order = Order(orderName: orderNameTXT.text!, cupsType: cupTypeTXT.text!, cupSize: cupSizeTXT.text!, qyt: qytLBL.text!, price: priceLBL.text!, forUser: userRef)
        
        do { let orderRef = try db.collection("orders").addDocument(from: order, completion: { err in
            if err == nil {
               print("Orde Save Successfully")
            }
        })
            
            userRef.setData(["orders" : FieldValue.arrayUnion([orderRef])], merge: true)
            
            
        } catch {
            
        }
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
       print("Local URL of selected file \(url)")
        
       guard let pdfData = try? Data(contentsOf: url) else {return}
        
       let firebaseStorageReferecne = Storage.storage().reference()
       let pdfReference = firebaseStorageReferecne.child("/PDFs/\(UUID().uuidString)")
        
       let meta = StorageMetadata()
       meta.contentType = "application/pdf"
        
       let uploadTask = pdfReference.putData(pdfData, metadata: meta)
        
       uploadTask.observe(.success, handler: { _ in
         pdfReference.downloadURL { onlineURL, error in
            
           print(onlineURL?.absoluteString)
         }
       })
     }
   
    
    @IBAction func uploadFileOnTapped(_ sender: Any) {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func stepperOnTapped(_ sender: UIStepper) {
        qytLBL.text = String(sender.value)
        priceLBL.text = String((sender.value)*2)
    }
    
    
    @IBAction func placeOrderOnTapped(_ sender: Any) {
        uploadOrderInfo()
        
    }
    
    
    
    
    
    
    
    
    
}
