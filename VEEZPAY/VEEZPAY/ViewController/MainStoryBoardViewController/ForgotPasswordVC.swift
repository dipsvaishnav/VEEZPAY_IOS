//
//  ForgotPasswordVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 09/11/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet var txtMobile: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return true
    }
    func SendOTPAPICAlling(Parm:[String:Any]) {
        WebServices.shared.request(type: GetLoginData.self, APIPath:.ForgotPassword, info:Parm) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "VerifyOtpVC") as! VerifyOtpVC
                        destinationVC.ParmInfo = Parm
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
    
    @IBAction func btnSubmitTap(_ sender: Any) {
        guard ValidationCheck() else{return}
        if txtMobile.text?.isNumeric == true {
            SendOTPAPICAlling(Parm: ["country_code":"91","mobile":txtMobile.text ?? "","type":"mobile"])
        }
        else{
            SendOTPAPICAlling(Parm: ["email":txtMobile.text ?? "","type":"email"])
        }
//        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "VerifyOtpVC") as! VerifyOtpVC
//        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @IBAction func btnLoginClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
