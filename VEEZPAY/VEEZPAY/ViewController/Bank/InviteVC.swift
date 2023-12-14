//
//  InviteVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 26/10/23.
//

import UIKit

class InviteVC: UIViewController {
    @IBOutlet var usertbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usertbl.register(UINib(nibName: "UserContactTVCell", bundle: nil), forCellReuseIdentifier: "UserContactTVCell")
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
extension InviteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserContactTVCell", for: indexPath) as! UserContactTVCell
        return cell
    }
}
