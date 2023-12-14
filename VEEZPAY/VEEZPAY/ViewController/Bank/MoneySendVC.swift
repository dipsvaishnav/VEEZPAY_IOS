//
//  MoneySendVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 22/10/23.
//

import UIKit
import IQKeyboardManagerSwift

class MoneySendVC: UIViewController {
    @IBOutlet var tblTransaction: UITableView!
    var userInfo:ResultSearcher?
    @IBOutlet weak var view_Bottom: NSLayoutConstraint!
    @IBOutlet weak var txtAmount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTransaction.register(UINib(nibName: "MoneyRecivedTVCell", bundle: nil), forCellReuseIdentifier: "MoneyRecivedTVCell")
        tblTransaction.register(UINib(nibName: "MoneySendVCell", bundle: nil), forCellReuseIdentifier: "MoneySendVCell")
        let ChatHeaderNib = UINib.init(nibName: "ChatTimeHeader", bundle: Bundle.main)
        self.tblTransaction.register(ChatHeaderNib, forHeaderFooterViewReuseIdentifier: "ChatTimeHeader")
            // tblTransaction.tableFooterView = UIView()
        tblTransaction.tableFooterView = nil
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    //MARK: - getKayboardHeight
    @objc  func keyboardWillShow(notification: Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        print(keyboardHeight)
        let tabBarHeight = tabBarController?.tabBar.frame.size.height
       // self.view_Bottom.constant = keyboardHeight + 20 - (tabBarHeight ?? 100.00)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            
            if UIScreen.main.bounds.height > 750 {
                self.view_Bottom.constant = keyboardHeight - 20
            }
            else{
                self.view_Bottom.constant = keyboardHeight + 20
            }
            print("Device Height..",UIScreen.main.bounds.height)
//            self.view_Bottom.constant = keyboardHeight
            self.view.layoutIfNeeded()
           // self.scrollViewToEnd()
        },completion: { (finished) -> Void in
            if finished {
                
            }
        })
        
    }
    @IBAction func btnPayClick(_ sender: UIButton) {
        guard !txtAmount.text!.isEmptyStr else {
            ShowMessage(message: AllErrorMessage.EmptyAmountField, view: self)
            return
        }
        guard txtAmount.text?.stripCurrency() ?? 0.0 > 0 else{
            ShowMessage(message: "Payment amount can’t be zero", view: self)
            return
        }
        SendMoneyAPI(Parm: [
            "country_code":"91",
            "mobile":userInfo?.mobile ?? "",
            "amount":txtAmount.text ?? "",
            "message":"",
            "transferType":"mobile",
            "receiver_type":"user"
        ])
    }
    func SendMoneyAPI(Parm:[String:Any]) {
        WebServices.shared.request(type: UpdateMyProfile.self, APIPath:.TransferMoneyMobile, info:Parm) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                     print(logins)
                        ShowMessage(message:logins.message ?? "Money transferred from wallet to mobile number successfully.", view: self)
                        self.txtAmount.text = ""
                    }else{
                        ShowMessage(message:logins.message ?? "Error", view: self)
                    }
                }
                break
            case .failure(let error):
                print("error",error)
                break
            }
            
        }
    }
//    func scrollViewToEnd()
//    {
//        if self.arrayChatHistory.count > 0
//        {
//            let arrD = self.arrayChatHistory[self.arrayChatHistory.count - 1].ChatList.count
//            if arrD > 0
//            {
//                let indexP = IndexPath.init(row: arrD - 1, section: self.arrayChatHistory.count - 1)
//                self.chatTableView?.scrollToRow(at: indexP, at: .bottom, animated: false)
//
//            }
//        }
//    }
    @objc  func keyboardWillHide(notification: Notification) {
        view_Bottom.constant = 8.0
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(MoneySendVC.self)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        IQKeyboardManager.shared.enabledDistanceHandlingClasses.append(MoneySendVC.self)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
//        SocketIOManager.sharedInstance.socket.emit(JoynnEvents.offLine.rawValue, ["user_id":CommonMethods.sharedInstance.getUserID()])
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
extension MoneySendVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyRecivedTVCell", for: indexPath) as! MoneyRecivedTVCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoneySendVCell", for: indexPath) as! MoneySendVCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ChatTimeHeader") as! ChatTimeHeader
        headerView.backgroundColor = .red
       // headerView.lblTitle.text = Date.getCurrentDate() == arrayChatHistory[section].ChatDate ? "Today" : arrayChatHistory[section].ChatDate
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 24
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
