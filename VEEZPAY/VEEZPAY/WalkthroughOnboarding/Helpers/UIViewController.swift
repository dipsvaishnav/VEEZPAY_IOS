//
//  UIViewController.swift
//  WalkthroughOnboarding
//
//  Created by Florian Marcu on 8/16/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func addChildViewControllerWithView(_ childViewController: UIViewController, toView view: UIView? = nil) {
    let view: UIView = view ?? self.view
    childViewController.removeFromParent()
    childViewController.willMove(toParent: self)
    addChild(childViewController)
    childViewController.didMove(toParent: self)
    childViewController.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(childViewController.view)
    view.addConstraints([
      NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -10),
      NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
    ])
    view.layoutIfNeeded()
  }
  
  func removeChildViewController(_ childViewController: UIViewController) {
    childViewController.removeFromParent()
    childViewController.willMove(toParent: nil)
    childViewController.removeFromParent()
    childViewController.didMove(toParent: nil)
    childViewController.view.removeFromSuperview()
    view.layoutIfNeeded()
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
    func presentNavigationBarTransaction() {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                
                let statusbarView = UIView()
                statusbarView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.5450980392, blue: 1, alpha: 1)
                view!.addSubview(statusbarView)
              
                statusbarView.translatesAutoresizingMaskIntoConstraints = false
                statusbarView.heightAnchor
                    .constraint(equalToConstant: statusBarHeight).isActive = true
                statusbarView.widthAnchor
                    .constraint(equalTo: view!.widthAnchor, multiplier: 1.0).isActive = true
                statusbarView.topAnchor
                    .constraint(equalTo: view!.topAnchor).isActive = true
                statusbarView.centerXAnchor
                    .constraint(equalTo: view!.centerXAnchor).isActive = true
              
            }
           else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.5450980392, blue: 1, alpha: 1)
            }
    }
}
