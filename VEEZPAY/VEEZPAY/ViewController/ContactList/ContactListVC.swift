//
//  ContactListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 10/12/23.
//

import UIKit
import Contacts
import ContactsUI
class ContactListVC: UIViewController {
    @IBOutlet var tblContactList: UITableView!
    var ArrayContact  : NSMutableArray = []
    var arrayContact = [ContactList]()
    var array_ContactListMain = [ContactList]()
    var ContactSelecte: ((ContactList) -> Void)?
    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "ContactListTVCell", bundle: nil)
        self.tblContactList.register(nib, forCellReuseIdentifier: "ContactListTVCell")
        FetchContact()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnRefresh(_ sender: UIButton) {
        arrayContact.removeAll()
        FetchContact()
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    func FetchContact(){
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (isGranted, error) in
            if isGranted == true
            {
                DispatchQueue.main.async {
                    self.ArrayContact = (ContactOperations.fetchContactDetail() ).mutableCopy() as! NSMutableArray
                    
                    //let phoneNumberData : NSMutableArray = []
                    for i in 0..<self.ArrayContact .count
                    {
                        let tempDict =  self.ArrayContact .object(at: i) as! NSDictionary
                        if  tempDict.object(forKey: "mobile") as! String != ""
                        {
                            let  obj:ContactList = ContactList(Name: tempDict.object(forKey: "name") as? String,ConatctNo: tempDict.object(forKey: "mobile") as? String)
                            self.arrayContact.append(obj)
                        }
                    }
                    self.arrayContact =  self.arrayContact.sorted(by: { $0.Name?.lowercased() ?? "" < $1.Name?.lowercased() ?? ""})
                    self.array_ContactListMain = self.arrayContact
                    print(self.arrayContact.description)
                    self.tblContactList.reloadData()
                    
                }
                
                
                
            }
            else
            {
                AlertMessage(AppName, msg: "Contact permission", controller: self)
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
extension ContactListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrayContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let Fcell = tableView.dequeueReusableCell(withIdentifier: "ContactListTVCell", for: indexPath) as! ContactListTVCell
        Fcell.selectionStyle = .none
//        Fcell.lblName.text = (arrayContact[indexPath.row] as AnyObject).value(forKey: "name") as? String
//        Fcell.lblNumber.text = (arrayContact[indexPath.row] as AnyObject).value(forKey: "mobile") as? String
        Fcell.lblName.text = arrayContact[indexPath.row].Name
        Fcell.lblNumber.text = arrayContact[indexPath.row].ConatctNo
        let acronyms = Fcell.lblName.text?.getAcronyms()
        Fcell.lblShort.text = acronyms
        return Fcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: {
            self.ContactSelecte!(self.arrayContact[indexPath.row])
        })
    }
}
extension ContactListVC:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if searchBar.text!.isEmpty{
            self.arrayContact =  self.array_ContactListMain
            tblContactList.reloadData()
        } else
        {
            print(" search text %@ ",searchBar.text! as NSString)
            self.arrayContact = array_ContactListMain.filter{($0.Name?.range(of: searchText, options: .caseInsensitive) != nil) || ($0.ConatctNo?.range(of: searchText, options: .caseInsensitive) != nil)}
            searchBar.becomeFirstResponder()
            tblContactList.reloadData()
            searchBar.becomeFirstResponder()
        }
        
        tblContactList.reloadData()
        
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

struct ContactList {
    var Name:String?
    var ConatctNo:String?
}
// MARK: - Searcher
struct SerachUserDetail: Codable {
    let success: Bool?
    let message: String?
    let results: [ResultSearcher]?
}

// MARK: - Result
struct ResultSearcher: Codable {
    let id, name, mobile: String?
    let type: String?
    var countryCode:Any?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
       // case countryCode = "country_code"
        case mobile, type
    }
}
