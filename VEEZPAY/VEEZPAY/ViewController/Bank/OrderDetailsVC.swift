//
//  OrderDetailsVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 26/10/23.
//

import UIKit

class OrderDetailsVC: UIViewController {
    @IBOutlet var BrandFaishonCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        BrandFaishonCollection.register(UINib.init(nibName: "BrandFaishonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandFaishonCollectionViewCell")
        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal //this is for direction
        layout3.minimumInteritemSpacing = 23
        BrandFaishonCollection.tag = 103
        layout3.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        layout3.itemSize = CGSize(width:130, height: 160)
        self.BrandFaishonCollection.setCollectionViewLayout(layout3, animated: true)
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
extension OrderDetailsVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandFaishonCollectionViewCell", for: indexPath) as! BrandFaishonCollectionViewCell
        return cell
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 160)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
