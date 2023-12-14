//
//  AddMoneyWalletVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 08/12/23.
//

import UIKit

class AddMoneyWalletVC: UIViewController {
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProfileAPICAlling()
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        GetProfileAPICAlling()
//    }
    @IBAction func btnPayClick(_ sender: UIButton) {
        guard !txtAmount.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyAmountField, view: self)
            return
        }
        guard txtAmount.text?.stripCurrency() ?? 0.0 > 0 else{
            ShowMessage(message: "Payment amount can’t be zero", view: self)
            return
        }
        AddMoneyAPICAlling() 
    }
    func AddMoneyAPICAlling() {
        WebServices.shared.request(type: AddMoney.self, APIPath:.AddMoney, info:["amount":txtAmount.text ?? ""]) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                        self.lblWalletBalance.text = "₦ \(logins.results?.walletAmount ?? "0.00")"
                        self.txtAmount.text = ""
                        ShowMessage(message: logins.message ?? "Money added to wallet successfully.", view: self)
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
    func GetProfileAPICAlling() {
        WebServices.shared.request(type: GetMyProfile.self, APIPath:.MyProfile, info:nil) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                        self.lblWalletBalance.text = "₦ \(logins.results?.walletAmount ?? "0.00")"
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
