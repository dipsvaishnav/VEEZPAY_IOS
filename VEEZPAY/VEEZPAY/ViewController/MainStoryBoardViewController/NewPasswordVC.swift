//
//  NewPasswordVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 09/11/23.
//

import UIKit

class NewPasswordVC: UIViewController {
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfrimPassword: UITextField!
    var strUserId:String = ""
    var strType:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnDoneTap(_ sender: Any) {
        guard !txtPassword.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyPassword, view: self)
            return
        }
        guard txtConfrimPassword.text! == txtPassword.text! else {
            ShowMessage(message: AllErrorMessage.MatchPassword, view: self)
            return
        }
        SetNewPasswordAPICAlling(Parm: ["userId":strUserId,
                                        "password":txtPassword.text ?? "",
                                        "type": strType])
    }
    func SetNewPasswordAPICAlling(Parm:[String:Any]) {
        WebServices.shared.request(type: GetLoginData.self, APIPath:.RestPassword, info:Parm) { result in
            switch result {
            case .success(let logins):
                print(result)
                DispatchQueue.main.async{
                    if logins.success != false {
                        ShowMessage(message: logins.message ?? "something went wrong", view: self)
                        self.navigationController?.popToRootViewController(animated: true)
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
