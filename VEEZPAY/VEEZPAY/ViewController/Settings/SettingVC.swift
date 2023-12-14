//
//  SettingVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 26/11/23.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblUPIid: UILabel!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgQrCode: UIImageView!
    @IBOutlet weak var lblDescprtion: UILabel!
    
    var DictProfileInfo:ResultsGetMyProfile?
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProfileQRCodeAPICAlling()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetProfileAPICAlling()
    }
    func GetProfileAPICAlling() {
        WebServices.shared.request(type: GetMyProfile.self, APIPath:.MyProfile, info:nil) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                        self.DictProfileInfo = logins.results
                        self.SetData()
                    }else{
                        ShowMessage(message: logins.message ?? "something went wrong", view: self)
                    }
                }
                break
            case .failure(let error):
                print("error",error)
                break
            }
            
        }
    }
    func GetProfileQRCodeAPICAlling() {
        WebServices.shared.request(type: QRMyProfile.self, APIPath:.CustomerQrCode, info:nil) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                        if Data(base64Encoded:self.SplitBase64(Signature:logins.results ?? "")) != nil{
                            let decodedimage = self.convertBase64StringToImage(imageBase64String: self.SplitBase64(Signature:logins.results ?? ""))
                            self.imgQrCode.image = decodedimage
                        }
                    }else{
                        ShowMessage(message: logins.message ?? "something went wrong", view: self)
                    }
                }
                break
            case .failure(let error):
                print("error",error)
                break
            }
            
        }
    }
    func SplitBase64(Signature:String)->String{
        if Signature.contains("base64,") == true {
            let Sign = Signature.components(separatedBy: "base64,")
            if Sign.count > 1 {
                return Sign[1]
            }
            else{
                return Signature
            }
        }
        return Signature
    }
    func convertBase64StringToImage (imageBase64String: String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        if imageData != nil {
            let image = UIImage(data: imageData!)
//            if image == nil{
//                return UIImage()
//            }
            return image ?? UIImage()
        }
        else{
            return UIImage()
        }
    }
    func SetData() {
        lblName.text = "\(DictProfileInfo?.firstName ?? "") \(DictProfileInfo?.lastName ?? "")"
        lblUPIid.text = "UPI ID : \(DictProfileInfo?.mobile ?? "")@qpay  "
        lblMobileNo.text = "+\(DictProfileInfo?.countryCode ?? 91) \(DictProfileInfo?.mobile ?? "")"
        lblWalletBalance.text = "₦ \(DictProfileInfo?.walletAmount ?? "0.00")"
        lblDescprtion.text = "Anyone can scan this QR or send money to you on \(DictProfileInfo?.mobile ?? ""). You will receive money in your default bank account (FIRST Bank - xxxx)"
        if DictProfileInfo?.profilePic != nil {
            self.imgProfile.setImageWithUrl(URL(string:(DictProfileInfo?.profilePic ?? "")!)!, placeHolderImage:#imageLiteral(resourceName: "ProfileImage"))
        }
        
    }
    @IBAction func btnUpdateProfileClick(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        destinationVC.DictProfileInfo = DictProfileInfo
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnKYCClick(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "KYCVerificationVC") as! KYCVerificationVC
        //destinationVC.DictProfileInfo = DictProfileInfo
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnAddMoneyClick(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "AddMoneyWalletVC") as! AddMoneyWalletVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnLogoutClick(_ sender: UIButton) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            RemoveKey(UDKey.kUser_ID)
            sd.LogoutFromApp()
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
struct QRMyProfile: Codable {
    let success: Bool?
    let message: String?
    let results: String?
}
