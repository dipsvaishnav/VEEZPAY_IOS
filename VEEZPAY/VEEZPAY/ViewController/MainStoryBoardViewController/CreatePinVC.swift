//
//  CreatePinVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 08/11/23.
//

import UIKit

class CreatePinVC: UIViewController {
    @IBOutlet var otpTextFieldView: AEOTPTextField!
    @IBOutlet var ConfrimotpTextFieldView: AEOTPTextField!
    @IBOutlet var btnEyes: UIButton!
   // Property 1=EyeSlashActive
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEyes.isSelected = true
        otpTextFieldView.otpDelegate = self
        otpTextFieldView.configure(with: 6)
        otpTextFieldView.otpTextIsSecure = true
        
        ConfrimotpTextFieldView.otpDelegate = self
        ConfrimotpTextFieldView.configure(with: 6)
        ConfrimotpTextFieldView.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func btnEyeTap(_ sender: Any) {
        
        if btnEyes.isSelected == false {
            otpTextFieldView.otpDelegate = self
            otpTextFieldView.configure(with: 6)
            otpTextFieldView.otpTextIsSecure = false
            btnEyes.isSelected = true
            btnEyes.setImage(UIImage(named: "Property 1=EyeOutline"), for: .normal)
        }
        else{
            btnEyes.isSelected = false
            otpTextFieldView.otpDelegate = self
            otpTextFieldView.configure(with: 6)
            otpTextFieldView.otpTextIsSecure = true
            btnEyes.setImage(UIImage(named: "Property 1=EyeSlashActive"), for: .normal)
        }
    }
    @IBAction func btnDoneTap(_ sender: Any) {
        guard !otpTextFieldView.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyPINPassword, view: self)
            return
        }
        guard ConfrimotpTextFieldView.text! == otpTextFieldView.text! else {
            ShowMessage(message: AllErrorMessage.EmptyCPINPassword, view: self)
            return
        }
        CreatePINAPICAlling() 
    }
    func CreatePINAPICAlling() {
        WebServices.shared.request(type: GetLoginData.self, APIPath:.Setsecuritypin, info:["pin":otpTextFieldView.text ?? ""]) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        ShowMessage(message: logins.message ?? "something went wrong", view: self)
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
extension CreatePinVC: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
        //otpNumber = code
    }
}
