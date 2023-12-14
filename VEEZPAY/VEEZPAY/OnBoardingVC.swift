//
//  OnBoardingVC.swift
//  VEEZPAY
//
//  Created by DEEPAK on 17/10/23.
//

import UIKit

class OnBoardingVC: UIViewController,  ATCWalkthroughViewControllerDelegate{
  let walkthroughs = [
    ATCWalkthroughModel(title: "Send & Receive Money", subtitle: "Your Virtual Wallet is now a Reality. Fast and easy way to send and receive money", icon: "Rectangle 1264"),
    ATCWalkthroughModel(title: "Easy Bank Transfers", subtitle: "National and international transfers at your fingertips", icon: "Rectangle 1264"),
    ATCWalkthroughModel(title: "Bill Payments", subtitle: "National and international transfers at your fingertips", icon: "Rectangle 1264"),
    //ATCWalkthroughModel(title: "Get Notified", subtitle: "Receive notifications when critical situations occur to stay on top of everything important.", icon: "Rectangle 1264"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let walkthroughVC = self.walkthroughVC()
    walkthroughVC.delegate = self
    self.addChildViewControllerWithView(walkthroughVC)
    Save("kFirstTimeLaunch", keyname: UDKey.kFirstTimeLaunch)
  }
  
  func walkthroughViewControllerDidFinishFlow(_ vc: ATCWalkthroughViewController) {
    UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
      vc.view.removeFromSuperview()
      let viewControllerToBePresented = UIViewController()
      self.view.addSubview(viewControllerToBePresented.view)
        let destinationVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }, completion: nil)
  }
  
  fileprivate func walkthroughVC() -> ATCWalkthroughViewController {
    let viewControllers = walkthroughs.map { ATCClassicWalkthroughViewController(model: $0, nibName: "ATCClassicWalkthroughViewController", bundle: nil) }
    return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController",
                                        bundle: nil,
                                        viewControllers: viewControllers)
  }
}
