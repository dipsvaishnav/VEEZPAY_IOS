//
//  DTHRechargeListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 03/11/23.
//

import UIKit

class DTHRechargeListVC: UIViewController {
    @IBOutlet var DTHPopularCollection: UICollectionView!
    @IBOutlet var DTHOtherCollection: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var BannerCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DTHPopularCollection.register(UINib.init(nibName: "DTHCVCell", bundle: nil), forCellWithReuseIdentifier: "DTHCVCell")
        
        DTHOtherCollection.register(UINib.init(nibName: "DTHCVCell", bundle: nil), forCellWithReuseIdentifier: "DTHCVCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //this is for direction
        layout.minimumInteritemSpacing = 23
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: self.DTHPopularCollection.frame.width, height: 90)
        self.DTHPopularCollection.setCollectionViewLayout(layout, animated: true)
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical //this is for direction
        layout1.minimumInteritemSpacing = 23
        layout1.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        layout1.itemSize = CGSize(width: self.DTHOtherCollection.frame.width, height: 90)
        self.DTHOtherCollection.setCollectionViewLayout(layout1, animated: true)
        
        
        let categoryNib = UINib.init(nibName: "TestCollectionViewCell", bundle: nil)
        BannerCollection.register(categoryNib, forCellWithReuseIdentifier: "TestCollectionViewCell")
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal //this is for direction
        layout2.minimumInteritemSpacing = 0
        layout2.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 23)
        layout2.itemSize = CGSize(width: self.BannerCollection.frame.width, height: 144)
        self.BannerCollection.setCollectionViewLayout(layout2, animated: true)
        startTimer()
        
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
extension DTHRechargeListVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            cell.imgBanner.contentMode = .scaleAspectFit
            if indexPath.row % 2 == 0 {
                cell.imgBanner.image =  UIImage(named: "Frame 10")
            }
            else{
                cell.imgBanner.image =  UIImage(named: "Frame 2")
            }
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DTHCVCell", for: indexPath) as! DTHCVCell
                cell.lblNumber.isHidden = collectionView.tag == 101 ? true:false
              return cell
        }
   
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 100{
            return CGSize(width: self.BannerCollection.frame.width, height: 144)
        }
        else{
            return CGSize(width: self.DTHOtherCollection.frame.width, height: 90)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
