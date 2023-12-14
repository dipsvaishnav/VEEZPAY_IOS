//
//  SplitMainVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 05/11/23.
//

import UIKit

class SplitMainVC: UIViewController {

    @IBOutlet var tblSplitList: UITableView!
    @IBOutlet var btnToggle: [UIButton]!
    @IBOutlet var lblLine: [UILabel]!
    var isTypeSplit = SplitType.SplitByEvenly
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSplitList.register(UINib(nibName: "SplitEventTVCell", bundle: nil), forCellReuseIdentifier: "SplitEventTVCell")
        tblSplitList.register(UINib(nibName: "SplitShareTVCell", bundle: nil), forCellReuseIdentifier: "SplitShareTVCell")
        tblSplitList.register(UINib(nibName: "SplitPercentTVCell", bundle: nil), forCellReuseIdentifier: "SplitPercentTVCell")

        // Do any additional setup after loading the view.
    }
    @IBAction func btnToggleMenuPress(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            isTypeSplit = .SplitByEvenly
            break
        case 1:
            isTypeSplit = .SplitByAmounts
            break
        case 2:
            isTypeSplit = .SplitByShares
            break
        default:
            isTypeSplit = .SplitByPercentages
        }
        tblSplitList.reloadData()
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
extension SplitMainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch isTypeSplit {
        case .SplitByEvenly:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SplitEventTVCell", for: indexPath) as! SplitEventTVCell
            cell.selectionStyle = .none
            cell.lblLine.isHidden = true
            return cell
        case .SplitByAmounts:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SplitEventTVCell", for: indexPath) as! SplitEventTVCell
            cell.selectionStyle = .none
            cell.lblLine.isHidden = false
            return cell
        case .SplitByShares:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SplitShareTVCell", for: indexPath) as! SplitShareTVCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SplitPercentTVCell", for: indexPath) as! SplitPercentTVCell
            cell.selectionStyle = .none
            return cell
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
}

enum SplitType {
case SplitByEvenly
case SplitByAmounts
case SplitByShares
case SplitByPercentages
}
final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric,
                     height: contentSize.height + adjustedContentInset.top)
    }
}
