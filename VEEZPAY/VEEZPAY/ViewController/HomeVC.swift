//
//  HomeVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 19/10/23.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var BannerCollection: UICollectionView!
    @IBOutlet var BannerAddCollection: UICollectionView!
    @IBOutlet var BrandCollection: UICollectionView!
    @IBOutlet var BrandFaishonCollection: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var pageAddControl: UIPageControl!
    @IBOutlet weak var imgProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryNib = UINib.init(nibName: "TestCollectionViewCell", bundle: nil)
        BannerCollection.register(categoryNib, forCellWithReuseIdentifier: "TestCollectionViewCell")
        BannerAddCollection.register(categoryNib, forCellWithReuseIdentifier: "TestCollectionViewCell")
        BrandCollection.register(UINib.init(nibName: "BrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandCollectionViewCell")
        BrandFaishonCollection.register(UINib.init(nibName: "BrandFaishonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandFaishonCollectionViewCell")
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //this is for direction
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: self.BannerCollection.frame.width, height: 144)
        self.BannerCollection.setCollectionViewLayout(layout, animated: true)
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .horizontal //this is for direction
        layout1.minimumInteritemSpacing = 23
        layout1.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        layout1.itemSize = CGSize(width: self.BannerAddCollection.frame.width, height: 115)
        self.BannerAddCollection.setCollectionViewLayout(layout1, animated: true)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal //this is for direction
        layout2.minimumInteritemSpacing = 23
        layout2.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        layout2.itemSize = CGSize(width: self.BrandCollection.frame.width, height: 120)
        self.BrandCollection.setCollectionViewLayout(layout2, animated: true)
        
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal //this is for direction
        layout3.minimumInteritemSpacing = 23
        BrandFaishonCollection.tag = 103
        layout3.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        layout3.itemSize = CGSize(width:130, height: 160)
        self.BrandFaishonCollection.setCollectionViewLayout(layout3, animated: true)
        startTimer()
        if  Retrive(UDKey.kUser_ProfilePic) as? String != ""  {
            self.imgProfile.setImageWithUrl(URL(string:Retrive(UDKey.kUser_ProfilePic) as! String)!, placeHolderImage:#imageLiteral(resourceName: "ProfileImage"))
        }
        // Do any additional setup after loading the view.
    }
    func startTimer() {

        _ =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }


    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll  = BannerCollection {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < 3 - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    self.pageControl.currentPage = (indexPath?.row)! + 1
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    self.pageControl.currentPage = 0
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
        if let coll  = BannerAddCollection {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < 3 - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    self.pageAddControl.currentPage = (indexPath?.row)! + 1
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    self.pageAddControl.currentPage = 0
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
    @IBAction func btnToMobileNoClick(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "ContactListVC") as! ContactListVC
        destinationVC.ContactSelecte = { [weak self] (ContactcObj) in
            self?.SearchUserAvailabel(mobile: ContactcObj.ConatctNo ?? "")
        }
        self.present(destinationVC, animated: true)
    }
    
    func SearchUserAvailabel(mobile:String) {
        WebServices.shared.request(type: SerachUserDetail.self, APIPath:.SearchuserMobile, info:["mobile":mobile]) { result in
            switch result {
            case .success(let logins):
                DispatchQueue.main.async{
                    if logins.success != false {
                     print(logins)
                        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "MoneySendVC") as! MoneySendVC
                        if logins.results?.isEmpty == false {
                            destinationVC.userInfo = logins.results?[0]
                        }
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }else{
                        ShowMessage(message:"User not found or blocked by admin.", view: self)
                    }
                }
                break
            case .failure(let error):
                print("error",error)
                break
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
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            cell.imgBanner.image = UIImage(named: "Frame 2")
            return cell
        }
        else if collectionView.tag == 102{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
           // cell.imgBanner.image = UIImage(named: "Frame 2")
            return cell
        }
        else if collectionView.tag == 103{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandFaishonCollectionViewCell", for: indexPath) as! BrandFaishonCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
           // cell.imgBanner.image = UIImage(named: "Frame 2")
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            cell.imgBanner.image = UIImage(named: "Frame 3")
            return cell
        }
     
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 100{
            return CGSize(width: self.BannerCollection.frame.width, height: 144)
        }
        else if collectionView.tag == 102 {
            return CGSize(width: 130, height: 120)
        }
        else if collectionView.tag == 103 {
            return CGSize(width: 130, height: 160)
        }
        else{
            return CGSize(width: self.BannerCollection.frame.width, height: 115)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 102 || collectionView.tag == 103 {
            let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "AddToCartVC") as! AddToCartVC
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
     
    }
}
