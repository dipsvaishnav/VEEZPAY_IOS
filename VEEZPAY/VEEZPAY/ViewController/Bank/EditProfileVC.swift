//
//  EditProfileVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 23/10/23.
//

import UIKit
import IQKeyboardManagerSwift
class EditProfileVC: UIViewController {
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: IQTextView!
    @IBOutlet weak var imgProfile: UIImageView!
    var DictProfileInfo:ResultsGetMyProfile?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetData()
        // Do any additional setup after loading the view.
    }
    func SetData() {
        txtFname.text = DictProfileInfo?.firstName ?? ""
        txtLname.text = DictProfileInfo?.lastName ?? ""
        txtEmail.text = DictProfileInfo?.email ?? ""
        txtAddress.text = DictProfileInfo?.address ?? ""
        if DictProfileInfo?.profilePic != nil {
            self.imgProfile.setImageWithUrl(URL(string:(DictProfileInfo?.profilePic ?? "")!)!, placeHolderImage:#imageLiteral(resourceName: "ProfileImage"))
        }
        
    }
    @IBAction func btnimgProfilePicker(_ sender: UIButton) {
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

    @IBAction func btnUpdateTap(_ sender: Any) {
        guard ValidationCheck() else{return}
        UpdateProfileAPICAlling()

    }
    @IBAction func btnBackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func ValidationCheck() -> Bool {
        guard !txtFname.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyName, view: self)
            return false
        }
        guard !txtLname.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyLastName, view: self)
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
        guard imgProfile.image != nil else {
            ShowMessage(message: "select profile image", view: self)
            return false
        }
        return true
    }
    func UpdateProfileAPICAlling() {
        WebServices.shared.requestUploadImage(type: UpdateMyProfile.self, APIPath:.UpdateProfile, Method: .put, info: [
            "first_name": txtFname.text ?? "",
            "last_name": txtLname.text ?? "",
            "email": txtEmail.text ?? "",
            "address": txtAddress.text ?? "",
            "user_image":imgProfile.image ?? UIImage() //password & pin any one
        ]) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        ShowMessage(message: logins.message ?? "", view: self)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    else{
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
extension EditProfileVC : UIImagePickerControllerDelegate,
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
            self.imgProfile.image = image
        }
    }

}
