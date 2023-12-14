//
//  SignupVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 20/10/23.
//

import UIKit

class SignupVC: UIViewController {
    @IBOutlet var txtFName: UITextField!
    @IBOutlet var txtLName: UITextField!
    @IBOutlet var txtCountryCode: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtFrontImg: UITextField!
    @IBOutlet var txtBackImg: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var img_Profile: UIImageView!
    var img_Back =  UIImage()
    var img_Front = UIImage()
    var SelectImageType:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnCountryPicker(_ sender: UIButton) {
        let vc = CountryListVC()
        vc.didSelectCountry = { (name,code,image,ISO) -> Void in
            print(name)
           // self.imgFlag.image = UIImage(named: image)
            self.txtCountryCode.text = code
        }
        present(vc, animated: true)
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
    @IBAction func btnRegisterTap(_ sender: Any) {
        guard ValidationCheck() else{return}
        SignupAPICAlling()

    }
    func ValidationCheck() -> Bool {
        guard !txtFName.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyName, view: self)
            return false
        }
        guard !txtLName.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyLastName, view: self)
            return false
        }
        guard !txtMobile.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyMobileNumber, view: self)
            return false
        }
        guard txtMobile.text!.isPhone() else {
            ShowMessage(message: AllErrorMessage.invalidMobileNumber, view: self)
            return false
        }
        guard !txtEmail.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyEmail, view: self)
            return false
        }
        guard txtEmail.text!.isValidEmailId else {
            ShowMessage(message: AllErrorMessage.invalidEmailId, view: self)
            return false
        }
        guard !txtFrontImg.text!.isEmptyStr else {
            ShowMessage(message: "select front image", view: self)
            return false
        }
        guard !txtBackImg.text!.isEmptyStr else {
            ShowMessage(message:"select back image", view: self)
            return false
        }
        guard !txtPassword.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyPassword, view: self)
            return false
        }
        guard txtConfirmPassword.text! == txtPassword.text! else {
            ShowMessage(message: AllErrorMessage.EmptyPassword, view: self)
            return false
        }
        guard img_Profile.image != nil else {
            ShowMessage(message: "select profile image", view: self)
            return false
        }
        return true
    }
    @IBAction func btnLoginTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func SignupAPICAlling() {
        WebServices.shared.requestUploadImage(type: GetLoginData.self, APIPath:.Register, Method: .post, info: [
            "first_name": txtFName.text ?? "",
            "last_name": txtLName.text ?? "",
            "email": txtEmail.text ?? "",
            "country_code": txtCountryCode.text ?? "",
            "phone": txtMobile.text ?? "",
            "password": txtPassword.text ?? "",
            "confirm_password":txtConfirmPassword.text ?? "",
            "referral":"",
            "device_id":"",
            "device_type":"ios",
            "device_token":"",
            "identity_card_front":img_Front,
            "identity_card_back":img_Back,
            "profile_pic":img_Profile.image ?? UIImage() //password & pin any one
        ]) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        ShowMessage(message: logins.message ?? "", view: self)
                        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "VerifyOtpVC") as! VerifyOtpVC
                        destinationVC.ParmInfo = ["country_code":self.txtCountryCode.text ?? "","mobile":self.txtMobile.text ?? ""]
                        destinationVC.IsComingFromSignUp = true
                        self.navigationController?.pushViewController(destinationVC, animated: true)
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
extension SignupVC : UIImagePickerControllerDelegate,
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
                self.img_Profile.image = image
                
            }
            else if SelectImageType == 1 {
                self.img_Front = image
                txtFrontImg.text = "📷.png"
            }
            else{
                self.img_Back = image
                txtBackImg.text = "📷.png"
            }
        }
    }

}
