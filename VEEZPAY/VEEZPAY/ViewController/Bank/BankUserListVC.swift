//
//  BankUserListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 21/10/23.
//

import UIKit

class BankUserListVC: UIViewController {
    @IBOutlet var usertbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usertbl.register(UINib(nibName: "UserBankDetailTVCell", bundle: nil), forCellReuseIdentifier: "UserBankDetailTVCell")
        // Do any additional setup after loading the view.
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

extension BankUserListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserBankDetailTVCell", for: indexPath) as! UserBankDetailTVCell
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.viewBackGround.TopcornerRadiu = 4
        }
        else if indexPath.row == 3 {
            cell.viewBackGround.BottomcornerRadius = 4
        }
        else{
            cell.viewBackGround.BottomcornerRadius = 0
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
