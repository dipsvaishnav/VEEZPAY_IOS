//
//  BankListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 22/10/23.
//

import UIKit

class BankListVC: UIViewController {
    @IBOutlet var BankCollection: UICollectionView!
    @IBOutlet var BankOtherCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BankCollection.register(UINib.init(nibName: "BanklistCVCell", bundle: nil), forCellWithReuseIdentifier: "BanklistCVCell")
        BankOtherCollection.register(UINib.init(nibName: "OtherBankListCVCell", bundle: nil), forCellWithReuseIdentifier: "OtherBankListCVCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //this is for direction
        layout.minimumInteritemSpacing = 23
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: self.BankCollection.frame.width * 0.20, height: 80)
        self.BankCollection.setCollectionViewLayout(layout, animated: true)
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical //this is for direction
        layout1.minimumInteritemSpacing = 23
        layout1.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        layout1.itemSize = CGSize(width: self.BankOtherCollection.frame.width, height: 55)
        self.BankOtherCollection.setCollectionViewLayout(layout1, animated: true)
        // Do any additional setup after loading the view.
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
extension BankListVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanklistCVCell", for: indexPath) as! BanklistCVCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            //cell.imgBanner.image = UIImage(named: "Frame 2")
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherBankListCVCell", for: indexPath) as! OtherBankListCVCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            //cell.imgBanner.image = UIImage(named: "Frame 3")
            return cell
        }
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: "AddBankAccountDetailVC") as! AddBankAccountDetailVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 100 {
            return CGSize(width: self.BankCollection.frame.width * 0.20, height: 80)
        }
        else{
            return CGSize(width: self.BankOtherCollection.frame.width, height: 55)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}
