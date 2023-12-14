//
//  MyRewardsListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 18/11/23.
//

import UIKit

class MyRewardsListVC: UIViewController {

    @IBOutlet var Rewardstbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Rewardstbl.register(UINib(nibName: "RewardsTVCell", bundle: nil), forCellReuseIdentifier: "RewardsTVCell")
        // Do any additional setup after loading the view.
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
extension MyRewardsListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTVCell", for: indexPath) as! RewardsTVCell
        cell.selectionStyle = .none
        cell.lblTitle.text = "Earned through transactions on 12/11/2023"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "BankListVC") as! BankListVC
       // self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
