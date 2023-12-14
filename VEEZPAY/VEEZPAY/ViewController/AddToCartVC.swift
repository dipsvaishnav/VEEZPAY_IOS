//
//  AddToCartVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 31/10/23.
//

import UIKit

class AddToCartVC: UIViewController {

    @IBOutlet var BrandFaishonCollection: UICollectionView!
    @IBOutlet var BannerCollection: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        BrandFaishonCollection.register(UINib.init(nibName: "BrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandCollectionViewCell")
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal //this is for direction
        layout3.minimumInteritemSpacing = 23
        BrandFaishonCollection.tag = 103
        layout3.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        layout3.itemSize = CGSize(width:130, height: 160)
        self.BrandFaishonCollection.setCollectionViewLayout(layout3, animated: true)
        
        let categoryNib = UINib.init(nibName: "TestCollectionViewCell", bundle: nil)
        BannerCollection.register(categoryNib, forCellWithReuseIdentifier: "TestCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //this is for direction
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.BannerCollection.frame.width, height: 280)
        self.BannerCollection.setCollectionViewLayout(layout, animated: true)
        startTimer()
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
extension AddToCartVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
            cell.imgBanner.contentMode = .scaleToFill
            cell.imgBanner.image = UIImage(named: "Rectangle 1273")
            return cell
        }
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell
            //cell.lblTilte.text = arrayFilter[indexPath.item]
           // cell.imgBanner.image = UIImage(named: "Frame 2")
            return cell
        }
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 100{
            return CGSize(width: self.BannerCollection.frame.width, height: 280)
        }
        return CGSize(width: 130, height: 160)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
