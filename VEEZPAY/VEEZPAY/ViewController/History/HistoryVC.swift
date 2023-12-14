//
//  HistoryVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 18/11/23.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet var Historytbl: UITableView!
    var arrayHistory = [Doc]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Historytbl.register(UINib(nibName: "TransactionHistoryTVCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryTVCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetTransactionHistory()
    }
    func GetTransactionHistory() {
        WebServices.shared.request(type: TransactionHistory.self, APIPath:.TransactionHistory, info:nil) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                     print(logins)
                        self.arrayHistory = logins.results?.docs ?? []
                        self.Historytbl.reloadData()
                        //self.txtAmount.text = ""
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HistoryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTVCell", for: indexPath) as! TransactionHistoryTVCell
       
        cell.selectionStyle = .none
//        if arrayHistory[indexPath.row].type == "debit"{
//            cell.lblPaidTo.text = "Paid to"
//        }
        cell.lblPaidTo.text = arrayHistory[indexPath.row].type == "debit" ? "Paid to":"Received from"
        cell.lblFrom.text = arrayHistory[indexPath.row].type == "debit" ? "Debited from":"Credited to"
        cell.lblTime.text = convertDate(strDataType: arrayHistory[indexPath.row].createdAt ?? "")
        cell.TransactionType.image = arrayHistory[indexPath.row].type != "debit" ? UIImage(named: "akar-icons_arrow-down-right"):UIImage(named: "akar-icons_arrow-up-right")
        cell.lblAmount.text = "₦\(arrayHistory[indexPath.row].transactionAmount ?? 0 )"
        if arrayHistory[indexPath.row].type != "debit" {
            if arrayHistory[indexPath.row].senderData?.count != 0 {
                cell.lblMobileNo.text = "\(arrayHistory[indexPath.row].senderData?[0].firstName ?? "") \(arrayHistory[indexPath.row].senderData?[0].lastName ?? "")"
            }
            else{
                cell.lblMobileNo.text = "NA"
            }
        }
        else{
            if arrayHistory[indexPath.row].receiverData?.count != 0 {
                cell.lblMobileNo.text = "\(arrayHistory[indexPath.row].receiverData?[0].firstName ?? "") \(arrayHistory[indexPath.row].receiverData?[0].lastName ?? "")"
            }
            else{
                cell.lblMobileNo.text = "NA"
            }
        }
     
        if indexPath.row == 0 {
            cell.viewBackGround.TopcornerRadiu = 4
        }
        else if indexPath.row == arrayHistory.count - 1 {
            cell.viewBackGround.BottomcornerRadius = 4
        }
        else{
            cell.viewBackGround.BottomcornerRadius = 0
        }
        return cell
    }
    func convertDate(strDataType:String) ->String {
        let dateFro = DateFormatter()
        dateFro.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateVal = dateFro.date(from: strDataType)
        dateFro.dateFormat = "dd MMMM yyyy"
        if dateVal != nil {
            return dateFro.string(from: dateVal!)
        }else{
            return ""
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
       // self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
