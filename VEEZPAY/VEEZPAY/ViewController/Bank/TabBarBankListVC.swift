//
//  TabBarBankListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 16/11/23.
//

import UIKit

class TabBarBankListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnAddBankAccountTap(_ sender: Any) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "BankUserListVC") as! BankUserListVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
