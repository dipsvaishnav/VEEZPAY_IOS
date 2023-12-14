//
//  AddAddressVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 01/11/23.
//

import UIKit

class AddAddressVC: UIViewController {

    @IBOutlet var addresstbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addresstbl.register(UINib(nibName: "AddAddressTVCell", bundle: nil), forCellReuseIdentifier: "AddAddressTVCell")

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
extension AddAddressVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressTVCell", for: indexPath) as! AddAddressTVCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 207
    }
}
