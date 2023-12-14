//
//  KYCVerificationVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 25/10/23.
//

import UIKit
import IQKeyboardManagerSwift

class KYCVerificationVC: UIViewController {
    var ListIdProofDown = DropDown()
    @IBOutlet weak var txtidType: UITextField!
    @IBOutlet weak var txtAddress: IQTextView!
    @IBOutlet weak var img_Back: UIImageView!
    @IBOutlet weak var img_Front: UIImageView!
    var SelectImageType:Int = 0
    let imagePicker = UIImagePickerController()
    var imgBack =  UIImage()
    var imgFront = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDropDownClick(_ sender: UIButton) {
        ListIdProofDown.dataSource = ["Passport", "PAN card", "Aadhaar card","Driving license","Birth certificate","Marriage certificate"]
        ListIdProofDown.anchorView = sender
        ListIdProofDown.direction = .bottom
        ListIdProofDown.bottomOffset =  CGPoint(x: 0, y: sender.frame.height)
        ListIdProofDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtidType.text = item
        }
        ListIdProofDown.show()
    }
    @IBAction func btnimgProfilePicker(_ sender: UIButton) {
        SelectImageType = sender.tag
        Open_Gallery()
    }
    
    func Open_Gallery() {

         let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

         let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
             print("Cancel")
         }
         actionSheetControllerIOS8.addAction(cancelActionButton)

         let saveActionButton = UIAlertAction(title: "Take Photo", style: .default)
             { _ in
                print("Save")
                 if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                   let imagePicker = UIImagePickerController()
                                   imagePicker.delegate = self
                                   imagePicker.sourceType = .camera;
                                   imagePicker.allowsEditing = false
                                   self.present(imagePicker, animated: true, completion: nil)
                     
         }
        
         }
         actionSheetControllerIOS8.addAction(saveActionButton)
         let deleteActionButton = UIAlertAction(title: "Choose Photo", style: .default)
             { _ in
                 print("Delete")
                 if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                  let imagePicker = UIImagePickerController()
                                  imagePicker.delegate = self
                                  imagePicker.sourceType = .photoLibrary;
                                  imagePicker.allowsEditing = false
                                  self.present(imagePicker, animated: true, completion: nil)
                              }
         }
         actionSheetControllerIOS8.addAction(deleteActionButton)
         self.present(actionSheetControllerIOS8, animated: true, completion: nil)
     }
    @IBAction func btnBackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitClick(_ sender: UIButton) {
        guard ValidationCheck() else{return}
        KYCUpdateAPICAlling()
    }
    func ValidationCheck() -> Bool {
        guard !txtidType.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyDocumentType, view: self)
            return false
        }
        guard !txtAddress.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyAddress, view: self)
            return false
        }
        guard imgFront.pngData() != nil  else {
            ShowMessage(message: "select front side image", view: self)
            return false
        }
        guard imgBack.pngData()  != nil  else {
            ShowMessage(message: "select back side image", view: self)
            return false
        }
        return true
    }
    func KYCUpdateAPICAlling() {
        WebServices.shared.requestUploadImage(type: UpdateMyProfile.self, APIPath:.UpdateProfileKYC, Method: .put, info: [
            "address": txtAddress.text ?? "",
            "identity_card_front":img_Front.image ?? UIImage(),
            "identity_card_back":img_Back.image ?? UIImage()//password & pin any one
        ]) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        ShowMessage(message: logins.message ?? "", view: self)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // your code here
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        ShowMessage(message: logins.message ?? "something went wrong", view: self)
                    }
                }
                break
            case .failure(let error):
                print("error",error)
                break
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension KYCVerificationVC : UIImagePickerControllerDelegate,
UINavigationControllerDelegate
{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url.lastPathComponent)
            print(url.pathExtension)
                guard url.pathExtension != "gif" else {
                    picker.dismiss(animated: true)
                    AlertMessage(AppName, msg: "Only image format allowd")
                    return
                }
            }
        picker.dismiss(animated: true)
        if ((info[.originalImage] as? UIImage) != nil)
        {
            guard let image = info[.originalImage] as? UIImage else {
                print("No image found")
                return
            }
             if SelectImageType == 0 {
                 self.img_Front.image = image
                 self.imgFront = image
//                txtFrontImg.text = "📷.png"
            }
            else{
                self.img_Back.image = image
                self.imgBack = image
                //txtBackImg.text = "📷.png"
            }
        }
    }

}
