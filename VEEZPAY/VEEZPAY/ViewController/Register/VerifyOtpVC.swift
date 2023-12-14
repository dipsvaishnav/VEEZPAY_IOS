//
//  VerifyOtpVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 09/11/23.
//

import UIKit

class VerifyOtpVC: UIViewController {

    @IBOutlet var otpTextFieldView: AEOTPTextField!
    @IBOutlet weak var lbl_Timer: UILabel!
    @IBOutlet weak var btn_Resend: UIButton!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var lblSendTo: UILabel!
    var IsComingFromSignUp:Bool = false
    var ParmInfo = [String:Any]()
    var strOTP:String = ""
    var count = 60
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSendTo.text = ParmInfo["mobile"] as? String ?? ""
        otpTextFieldView.otpDelegate = self
        otpTextFieldView.configure(with: 6)
        otpTextFieldView.isSecureTextEntry = true
        btn_Resend.isEnabled = false
        btn_Resend.isUserInteractionEnabled = false
        self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
        })
           self.timer  = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(VerifyOtpVC.update), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    var dev = true

    @objc func update()
    {
        
        if(count > 0)
        {
            btn_Resend.alpha = 0.5
            btn_Resend.isEnabled = false
            btn_Resend.isUserInteractionEnabled = false
            let minutes = String(count / 60)
            var seconds = String(count % 60)
            lblResend.text = "Expire Login"
            if seconds.count == 1
            {
                seconds = "0"+seconds
            }
            lbl_Timer.text = "0\(minutes + ":" + seconds)"
            count = count - 1
        }
        else
        {
            lbl_Timer.text = "0\("01" + ":" + "00")"
            btn_Resend.alpha = 1.0
            btn_Resend.isEnabled = true
            btn_Resend.isUserInteractionEnabled = true
            lbl_Timer.text = ""
            lblResend.text = ""
            timer.invalidate()
        }

    }
    @IBAction func btnResendTap(_ sender: Any) {

        ResendAPICAlling()
    }
    func ResendAPICAlling() {
        WebServices.shared.request(type: GetLoginData.self, APIPath:.ResendOTP, info:ParmInfo) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
                        })
                        self.timer  = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(VerifyOtpVC.update), userInfo: nil, repeats: true)
                        self.count = 60
                        self.btn_Resend.isEnabled = false
                        self.btn_Resend.isUserInteractionEnabled = false
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
    @IBAction func btnVerifyTap(_ sender: Any) {
        if IsComingFromSignUp == true {
            ParmInfo["otp_phone"] = strOTP
            VerifyOTPAPICAlling()
        }
        else{
            ParmInfo["otp"] = strOTP
            ForgotPasswordVerifyAPICAlling()

        }
       
    }
    func VerifyOTPAPICAlling() {
        WebServices.shared.request(type: RegisterModel.self, APIPath:.VerifyOTP, info:ParmInfo) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        Save(logins.results?.token ?? "", keyname: UDKey.kUserToken)
                        Save(logins.results?.id ?? "", keyname: UDKey.kUser_ID)
                        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "TabbarRootVC") as! TabbarRootVC
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
    func ForgotPasswordVerifyAPICAlling() {
        WebServices.shared.request(type: ForgotPasswordVerifyModel.self, APIPath:.ForgotPasswordVerify, info:ParmInfo) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "NewPasswordVC") as! NewPasswordVC
                        destinationVC.strUserId = logins.results?.id ?? ""
                        destinationVC.strType = self.ParmInfo["type"] as? String ?? "email"
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
    @IBAction func btnBackClick(_ sender: UIButton) {
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
extension VerifyOtpVC: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
        strOTP = code
    }
}
