//
//  LoginVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 08/11/23.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRememberMe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtMobile.text =  "sharmaanil9925@gmail.com"
//        txtPassword.text = "123456"
        setInitView()
        // Do any additional setup after loading the view.
    }
    private func setInitView() {


        
        if let userName = KeyChain.load(key: "kLogIn_UserName"), let password = KeyChain.load(key: "kLogIn_Password") {
            do{
               // let userName = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userName) as? String ?? ""
                let userName = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userName) as? String ?? ""
                let password = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(password) as? String ?? ""
                print(userName,password)
                txtMobile.text = userName
                txtPassword.text = password
                btnRememberMe.isSelected = true
            }catch{
                print("Unable to successfully convert NSData to NSDictionary")
            }
        }else{
            btnRememberMe.isSelected = false
        }

    }
    
    @IBAction func btnRegisterClick(_ sender: UIButton) {
       // self.navigationController?.popViewController(animated: true)
        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @IBAction func btnForgotPasswordClick(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @IBAction func btnLoginClick(_ sender: UIButton) {
        guard ValidationCheck() else{return}
        if btnRememberMe.isSelected {
            do {
                let username : Data = try NSKeyedArchiver.archivedData(withRootObject: txtMobile.text ?? "", requiringSecureCoding: false)
                let password : Data = try NSKeyedArchiver.archivedData(withRootObject: txtPassword.text ?? "", requiringSecureCoding: false)
                _ = KeyChain.save(key: "kLogIn_UserName", data: username as Data)
                _ = KeyChain.save(key: "kLogIn_Password", data: password as Data)
            } catch {}
        }else{
            KeyChain.logout()
        }
        LoginAPICAlling() 

    }
    func ValidationCheck() -> Bool {
        guard !txtMobile.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyMobileAndMobileNumber, view: self)
            return false
        }
        if txtMobile.text?.isNumeric == true {
            guard txtMobile.text!.isPhone() else {
                ShowMessage(message: AllErrorMessage.invalidMobileNumber, view: self)
                return false
            }
        }
        else{
            guard txtMobile.text!.isValidEmailId else {
                ShowMessage(message: AllErrorMessage.invalidEmailId, view: self)
                return false
            }
        }
        guard !txtPassword.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyPassword, view: self)
            return false
        }
        return true
    }
    func LoginAPICAlling() {
        WebServices.shared.request(type: GetLoginData.self, APIPath:.Login, info: [
            "email": txtMobile.text ?? "",
            "password":txtPassword.text ?? "",
            "device_id":"",
            "device_type":"",
            "device_token":"",
            "loginType":"password" //password & pin any one
        ]) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                   
                        Save(logins.results?.token ?? "", keyname: UDKey.kUserToken)
                        Save(logins.results?.id ?? "", keyname: UDKey.kUser_ID)
                        Save(logins.results?.profilePic ?? "", keyname: UDKey.kUser_ProfilePic)
                        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "TabbarRootVC") as! TabbarRootVC
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                       
                    }else{
                        if logins.results?.isEmailVerified == 0 {
                            let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "VerifyOtpVC") as! VerifyOtpVC
                            destinationVC.IsComingFromSignUp = true
                            destinationVC.ParmInfo = ["email":self.txtMobile.text ?? ""]

                            self.navigationController?.pushViewController(destinationVC, animated: true)
                        }
                        else{
                            ShowMessage(message: logins.message ?? "something went wrong", view: self)
                        }
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
