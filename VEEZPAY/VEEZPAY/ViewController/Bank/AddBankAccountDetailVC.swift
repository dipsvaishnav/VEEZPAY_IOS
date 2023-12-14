//
//  AddBankAccountDetailVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 22/10/23.
//

import UIKit

class AddBankAccountDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnNextTap(_ sender: Any) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "MoneySendVC") as! MoneySendVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
