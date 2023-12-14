//
//  SplituserListVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 05/11/23.
//

import UIKit

class SplituserListVC: UIViewController {
    @IBOutlet var TopUserCollection: UICollectionView!
    @IBOutlet var GroupChatsCollection: UICollectionView!
    @IBOutlet var VeezPayCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TopUserCollection.register(UINib.init(nibName: "UserContactCVCell", bundle: nil), forCellWithReuseIdentifier: "UserContactCVCell")
        GroupChatsCollection.register(UINib.init(nibName: "DTHCVCell", bundle: nil), forCellWithReuseIdentifier: "DTHCVCell")
        VeezPayCollection.register(UINib.init(nibName: "DTHCVCell", bundle: nil), forCellWithReuseIdentifier: "DTHCVCell")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //this is for direction
        layout.minimumInteritemSpacing = 23
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.TopUserCollection.frame.width * 0.20, height: 80)
        self.TopUserCollection.setCollectionViewLayout(layout, animated: true)
        
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
extension SplituserListVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserContactCVCell", for: indexPath) as! UserContactCVCell
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DTHCVCell", for: indexPath) as! DTHCVCell
                //cell.lblNumber.isHidden = collectionView.tag == 101 ? true:false
              return cell
        }
   
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 100{
            return CGSize(width: self.TopUserCollection.frame.width * 0.30, height: 90)
        }
        if collectionView.tag == 101{
            return CGSize(width: self.GroupChatsCollection.frame.width, height: 75)
        }
        else{
            return CGSize(width: self.VeezPayCollection.frame.width, height: 75)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
