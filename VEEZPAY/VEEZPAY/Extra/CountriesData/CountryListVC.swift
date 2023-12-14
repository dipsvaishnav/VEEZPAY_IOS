//
//  CountryListVC.swift
//  Tivo
//
//  Created by Deepak Vaishnav on 01/02/22.
//

import UIKit
class CountryListVC: UIViewController {
    @IBOutlet weak var tbl_Chatlist: UITableView!
    var arrayCountryMain = [CountryListElement]()
    var arrayCountry = [CountryListElement]()
    let arraySection = ["Popular Countries","All Countries"]
    var didSelectCountry: ((String,String,String,String)->())?
    var TopCountry = [CountryListElement]()
    var TopCountryMain = [CountryListElement]()
    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayCountryMain = loadJson(filename: "CountryCodes") ?? []
        print(arrayCountry.description)
        let headerNib = UINib.init(nibName: "DemoHeaderView", bundle: Bundle.main)
                tbl_Chatlist.register(headerNib, forHeaderFooterViewReuseIdentifier: "DemoHeaderView")
                tbl_Chatlist.register(UINib(nibName: "CountryTVCell", bundle: nil), forCellReuseIdentifier: "CountryTVCell")
        tbl_Chatlist.tableFooterView = UIView()
        TopCountry = arrayCountryMain.filter({$0.code == "IN" || $0.code == "FR" || $0.code == "ES"})
        TopCountryMain = arrayCountryMain.filter({$0.code == "IN" || $0.code == "FR" || $0.code == "ES"})
        arrayCountry = arrayCountryMain.filter({$0.code != "IN" && $0.code != "FR" && $0.code != "ES"})
        tbl_Chatlist.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func loadJson(filename fileName: String) -> [CountryListElement]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CountryListData.self, from: data)
                return jsonData.countryList
            } catch {
                print("error:\(error)")
            }
        }
        return nil
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
extension CountryListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  section == 0 ? TopCountry.count : arrayCountry.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DemoHeaderView") as! DemoHeaderView
            headerView.lblTitle.text = arraySection[section]
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let Cell = tableView.dequeueReusableCell(withIdentifier: "CountryTVCell", for: indexPath) as? CountryTVCell
        if indexPath.section == 0 {
            Cell?.lblCountryName.text = TopCountry[indexPath.row].name
            Cell?.lblCountryCode.text = TopCountry[indexPath.row].dialCode
            Cell?.flgImage.image = UIImage(named: TopCountry[indexPath.row].code + ".png")
        }
        else {
            Cell?.lblCountryName.text = arrayCountry[indexPath.row].name
            Cell?.lblCountryCode.text = arrayCountry[indexPath.row].dialCode
            Cell?.flgImage.image = UIImage(named: arrayCountry[indexPath.row].code)
        }
        Cell?.selectionStyle = .none
        return Cell ?? UITableViewCell.init()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: {
            if indexPath.section == 0 {
                self.didSelectCountry?(self.TopCountry[indexPath.row].name,self.TopCountry[indexPath.row].dialCode,self.TopCountry[indexPath.row].code + ".png", self.TopCountry[indexPath.row].code)
            }
            else {
                self.didSelectCountry?(self.arrayCountry[indexPath.row].name,self.arrayCountry[indexPath.row].dialCode,self.arrayCountry[indexPath.row].code,self.arrayCountry[indexPath.row].code)
            }
        })
    }
    
    
}
extension CountryListVC:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        
        if searchBar.text!.isEmpty{
            TopCountry = arrayCountryMain.filter({$0.code == "IN" || $0.code == "FR" || $0.code == "ES"})
            arrayCountry = arrayCountryMain.filter({$0.code != "IN" && $0.code != "FR" && $0.code != "ES"})
            tbl_Chatlist.reloadData()
        } else
        {
            self.TopCountry = TopCountryMain.filter{($0.name.range(of: searchText, options: .caseInsensitive) != nil) || ($0.dialCode.range(of: searchText, options: .caseInsensitive) != nil)}
            self.arrayCountry = arrayCountryMain.filter{($0.name.range(of: searchText, options: .caseInsensitive) != nil) || ($0.dialCode.range(of: searchText, options: .caseInsensitive) != nil)}
            searchBar.becomeFirstResponder()
            tbl_Chatlist.reloadData()
            searchBar.becomeFirstResponder()
        }
        
        tbl_Chatlist.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     //   searchBar.text = ""
        self.view.endEditing(true)
    }
}
// MARK: - CountryList
struct CountryListData: Codable {
    let countryList: [CountryListElement]
}

// MARK: - CountryListElement
struct CountryListElement: Codable {
    let name, dialCode, code: String

    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
    }
}
