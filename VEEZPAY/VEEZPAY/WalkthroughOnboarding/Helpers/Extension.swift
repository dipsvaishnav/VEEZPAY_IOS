//
//  Extension.swift
//  Karicare
//
//  Created by mac305 on 28/03/19.
//  Copyright © 2019 Deepak Vaishnav. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Toaster

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let AppName = "VEEZPAY"

enum AppStoryboard : String {
    case Main = "Main"
    case Home = "Home"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}
@IBDesignable
extension UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

// MARK: - RoundView
@IBDesignable public class RoundView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 4
        clipsToBounds = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}
// MARK: - RoundView
extension UILabel {
    func roundCornerss(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
@IBDesignable
extension UIView {
    @IBInspectable
    var TopcornerRadiu: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  
        }
    }
    @IBInspectable
    var BottomcornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners =  [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
  
        }
    }
    @IBInspectable
    var cornerRadiuView: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
@IBDesignable
extension UILabel {
    
    @IBInspectable
    var cornerRadiu: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

}

// MARK: - RoundUIImageView
@IBDesignable public class RoundImage: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
            clipsToBounds = true
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    @IBInspectable var rounded: Bool = false
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        self.clipsToBounds = true
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}
// MARK: - RoundUIImageView
@IBDesignable
class CardImage: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    override func layoutSubviews() {
  let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          self.layer.mask = mask
    }
    
}
@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
// MARK: - RoundUIImageView
public extension String {
    
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
    var isNumeric: Bool {
         guard self.count > 0 else { return false }
         let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
         return Set(self).isSubset(of: nums)
     }
}
extension String {
    var length: Int {
        return self.count
    }
}
func AlertMessage(_ title:String, msg:String, controller:UIViewController)
{
    //Deepak
    let alertController = UIAlertController(title: title,
                                            message: msg,
                                            preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
    controller.present(alertController, animated: true, completion: nil)
    
}

func ShowMessage(message:String,view:UIViewController)
{
    Toast.init(text: message).show()
//    let toast = Toast.text("Safari pasted from Notes", subtitle: "A few seconds ago")
//    self.toast = Toast.text(
//                "Safari pasted from Noted",
//                config: .init(
//                    direction: .bottom,
//                    enteringAnimation: .scale(scaleX: 0.6, scaleY: 0.6),
//                    exitingAnimation: .default
//                ).show()

    
}

func AlertMessage(_ title:String, msg:String)
{
    
    DispatchQueue.main.async
    {
        let alertController = UIAlertController(title:AppName,
                                                message: msg,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
       //  window?.rootViewController?.topMostViewController()
        window?.rootViewController?.topMostViewController().present(alertController, animated: true, completion: nil)
        
    }
    
}

public func AlertMessageClicked(Message:String, controller:UIViewController, withCompletion completion:@escaping (_ code:Bool)->())
{
    
    let alert = UIAlertController(title:AppName, message: Message, preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        
        controller.dismiss(animated: true, completion:{
            //self.completion("")
             completion(true)
        })
        
    })
    alert.addAction(ok)
    DispatchQueue.main.async(execute: {
        controller.present(alert, animated: true)
    })
}

extension UIAlertController {

func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1;
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
}
}

// MARK: NSUserDefault

func Save(_ str:String,keyname:String)
{
    UserDefaults.standard.setValue(str, forKey: keyname)
    UserDefaults.standard.synchronize()
}

func Retrive(_ str:String)-> AnyObject
{
    let retrivevalue =  UserDefaults.standard.value(forKey: str)
    
    if retrivevalue != nil
    {
        return retrivevalue! as AnyObject
    }
    return "" as AnyObject
}

func RemoveKey(_ str:String)
{
    UserDefaults.standard.removeObject(forKey: str)
}

func timeAgoSinceDate(from:Date, numericDates:Bool , toDate : Date) -> String {
    let calendar = Calendar.current
    let now = toDate
    // NSDate()
    let earliest = (now as NSDate).earlierDate(from as Date)
    let latest = earliest == now as Date ? from : now as Date
    let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
    
    
    
    
    if (components.year! >= 2) {
        return "\(components.year!) years"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days"
    } else if (components.day! >= 1)
    {
        if (numericDates)
        {
            return "1 day"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2)
        
    {
        return "\(components.hour!) hours"
    }
    else if (components.hour! >= 1)
    {
        if (numericDates){
            return "1 hour"
        } else {
            return "An hour"
        }
    }
    else if (components.minute! >= 2)
    {
        return "\(components.minute!) minutes"
    }
    else if (components.minute! >= 1)
    {
        if (numericDates){
            return "1 minute"
        } else {
            return "A minute"
        }
    }
    else if (components.second! >= 3)
    {
        return "\(components.second!) seconds"
    }
    else
    {
        return "Just now"
    }
    
}




extension UILabel {
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue),
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue), at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
    
}






@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

}
extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.40
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    
    
}
extension UIButton {
    func dropShadowButton() {
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.40
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    
    
    
}
extension UITextView {
    func dropShadowTextView() {
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.40
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    
    
}


extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    func stripCurrency() -> Double {
        let amount = self.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")
        return Double(amount) ?? 0.00
    }

}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    public func getAcronyms(separator: String = "") -> String
    {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first ?? " ") }).joined(separator: separator);
        return acronyms;
    }
}
@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColors: UIColor? = UIColor.black
    @IBInspectable var shadowOpacitys: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColors?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacitys
        layer.shadowPath = shadowPath.cgPath
    }
    
}
@IBDesignable
class NavigationView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var corners: UIRectCorner = UIRectCorner(rawValue: 0)
    
    override func layoutSubviews() {

        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UISearchBar {
    
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                textField.textColor = newValue
            }
        }
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
@objc(DSSCollectionViewFlowLayout)
class DSSCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare () {
        super.prepare()
        
        var contentByItems: ldiv_t
        
        let contentSize = self.collectionViewContentSize
        let itemSize = self.itemSize
        
        if UICollectionView.ScrollDirection.vertical == self.scrollDirection {
            contentByItems = ldiv (Int(contentSize.width), Int(itemSize.width))
        } else {
            contentByItems = ldiv (Int(contentSize.height), Int(itemSize.height))
        }
        
        let layoutSpacingValue = CGFloat(NSInteger (CGFloat(contentByItems.rem))) / CGFloat (contentByItems.quot + 1)
        
        let originalMinimumLineSpacing = self.minimumLineSpacing
        let originalMinimumInteritemSpacing = self.minimumInteritemSpacing
        let originalSectionInset = self.sectionInset
        
        if layoutSpacingValue != originalMinimumLineSpacing ||
            layoutSpacingValue != originalMinimumInteritemSpacing ||
            layoutSpacingValue != originalSectionInset.left ||
            layoutSpacingValue != originalSectionInset.right ||
            layoutSpacingValue != originalSectionInset.top ||
            layoutSpacingValue != originalSectionInset.bottom {
            
            let insetsForItem = UIEdgeInsets.init(top: layoutSpacingValue, left: layoutSpacingValue, bottom: layoutSpacingValue, right: layoutSpacingValue)
            
            self.minimumLineSpacing = layoutSpacingValue
            self.minimumInteritemSpacing = layoutSpacingValue
            self.sectionInset = insetsForItem
        }
    }
}

public func datePresentString() -> String {
       let date = Date()
       let dateFormatter = DateFormatter()
       let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
       dateFormatter.calendar = Calendar(identifier: .iso8601)
       dateFormatter.locale = enUSPosixLocale
       dateFormatter.timeZone = TimeZone.current
       dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
       
       let iso8601String = dateFormatter.string(from: date as Date)
       return iso8601String
   }
func convertVideoToLowQuailty(withInputURL inputURL: URL?, handler: @escaping (URL?) -> Void ) {
    let asset = AVAsset(url: inputURL!) // video url from library
        let fileMgr = FileManager.default
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = dirPaths[0].appendingPathComponent("Video_\(datePresentString()).mp4") //create new data in file manage .mp4
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        let fileManager = FileManager.default
                    
        do {
             try? fileManager.removeItem(at: filePath)
            }
//        catch {
//                print("can't")
//            }
        exportSession?.outputFileType = AVFileType.mp4
        exportSession?.metadata = asset.metadata
        exportSession?.outputURL = filePath
       exportSession?.exportAsynchronously {
        
          if exportSession?.status == .completed {
            handler(filePath)
        }
        
       }
    }
public extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
}
extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)
        
        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}
extension UIViewController {
   
        func isPresented() -> Bool {
            if self.presentingViewController != nil {
                return true
            } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
                return true
            } else if self.tabBarController?.presentingViewController is UITabBarController {
                return true
            }
            
            return false
        }

        func topMostViewController() -> UIViewController {
            if let navigation = self as? UINavigationController {
                if let visibleController = navigation.visibleViewController {
                    return visibleController.topMostViewController()
                }
            }
            if let tab = self as? UITabBarController {
                if let selectedTab = tab.selectedViewController {
                    return selectedTab.topMostViewController()
                }
                return tab.topMostViewController()
            }
            if let navigation = self.presentedViewController as? UINavigationController {
                if let visibleController = navigation.visibleViewController {
                    return visibleController.topMostViewController()
                }
            }
            if let tab = self.presentedViewController as? UITabBarController {
                if let selectedTab = tab.selectedViewController {
                    return selectedTab.topMostViewController()
                }
                return tab.topMostViewController()
            }
            if self.presentedViewController == nil {
                return self
            }
            
            return self.presentedViewController!.topMostViewController()
        }
  
    func showActionSheetWith(items:[String], title:String, message:String, completion:@escaping ((String) -> Void)) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for item in items {
            actionSheet.addAction(UIAlertAction(title: item, style: .default, handler: { (action) in
                completion(action.title!)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showDoubleButtonAlert(title:String, message:String, action1:String, action2:String, completion1:@escaping ()->(), completion2:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let act1 = UIAlertAction(title: action1, style: .default) { (action) in
            completion1()
        }
        let act2 = UIAlertAction(title: action2, style: .default) { (action) in
            completion2()
        }
        alert.addAction(act1)
        alert.addAction(act2)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true, completion: nil)
    }
    func showSingleButtonAlert(title:String, message:String, completion:@escaping ()->()) {

        
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let ok = UIAlertAction(title: "OK", style: .default) { (action) in
           completion()
       }
       alert.addAction(ok)
       present(alert, animated: true, completion: nil)
 }

}
extension UIApplication {
    func topMostViewController() -> UIViewController? {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.rootViewController?.topMostViewController()
    }
}
extension String {
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}

extension String {
    
    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
        func convertToDictionary() -> [String: Any]? {
            if let data = self.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }

    
    var isValidUserName:Bool {
        return testThe(regex: Regex.userNameRegex)
    }
    
    var isValidMobileNumber: Bool {
        return testThe(regex: Regex.phoneRegex)
    }
    
    var isValidPassword:Bool {
        return testThe(regex: Regex.passwordRegex)
    }
    
    var isValidEmailId:Bool {
        return testThe(regex: Regex.emailRegex)
    }
    
    var isValidEmailAndNumber:Bool {
        return testThe(regex: Regex.emailPhoneRegex)
    }
    
    func testThe(regex:String) -> Bool {
        if self.count > 0 {
            let predicate = NSPredicate(format: "SELF MATCHES %@",regex)
            return predicate.evaluate(with: self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))
        }
        return false
    }
}

struct Regex {
    static let userNameRegex   = "^[a-zA-Z ]{2,30}$"
    static let phoneRegex      = "^[0-9+]{0,1}+[0-9]{5,16}$"   //"^([0-9]{9,15})$"
    static let passwordRegex   = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$"
    static let emailRegex      = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
    static let emailPhoneRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$|^([0-9]{10,13})$"
}

extension Double {
    
    func secondsToHoursMinutesSeconds () -> (Int?, Int?, Int?) {
        let hrs = self / 3600
        let mins = (self.truncatingRemainder(dividingBy: 3600)) / 60
        let seconds = (self.truncatingRemainder(dividingBy:3600)).truncatingRemainder(dividingBy:60)
        return (Int(hrs) > 0 ? Int(hrs) : nil , Int(mins) > 0 ? Int(mins) : nil, Int(seconds) > 0 ? Int(seconds) : nil)
    }
    
    func printSecondsToHoursMinutesSeconds () -> String {
        
        let time = self.secondsToHoursMinutesSeconds()
        var strV = ""
        switch time {
        case (nil, let x? , let y?):
            return "00:\(x):\(y)"
        case (nil, let x?, nil):
            return "00:\(x)"
        case (let x?, nil, nil):
            x > 10 ? (strV = "\(x):00:00") : (strV = "0\(x):00:00")
        case (nil, nil, let x?):
            x > 10 ? (strV = "00:\(x)") : (strV = "00:0\(x)")
        case (let x?, nil, let z?):
            return "\(x):00:\(z)"
        case (let x?, let y?, nil):
            return "\(x):\(y):00"
        case (let x?, let y?, let z?):
            return "\(x):\(y):\(z)"
        default:
            return "00:00"
        }
        return strV
    }
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
extension UIApplication {
    /// Checks if view hierarchy of application contains `UIRemoteKeyboardWindow` if it does, keyboard is presented
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}
extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
let GAPI_Key                                                = "AIzaSyDTRgVPiwhF_LhxOFubR3bQC_PFcBQlq6Y"
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}

@IBDesignable
extension UIView {
//    @IBInspectable
//    var cornerRadiusView: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }

    @IBInspectable
    var borderWidthView: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColorView: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

}
public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1":
            return "iPhone 4"

        case "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPhone8,4":
            return "iPhone 5"

        case "iPhone7,2", "iPhone8,1", "iPhone9,1", "iPhone9,3", "iPhone10,1", "iPhone10,4":
            return "iPhone 6,7,8"

        case "iPhone7,1", "iPhone8,2", "iPhone9,2", "iPhone9,4", "iPhone10,2", "iPhone10,5":
            return "iPhone Plus"

        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"

        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
    }
}
extension UIApplication {
class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
    
    if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
    }
    
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
    }
    
    if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
    }

    return controller
}
}
extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}
func format(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator

    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}
@IBDesignable
class FAUGradientView: UIView {

    @IBInspectable var firstColor:UIColor = UIColor.clear
    @IBInspectable var secondColor:UIColor = UIColor.clear
    @IBInspectable var startPoint:CGPoint = CGPoint(x: 0.0, y: 0.0)
    @IBInspectable var endPoint:CGPoint = CGPoint(x: 0.0, y:1.0)

    var gradientLayer:CAGradientLayer!

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        gradientLayer = CAGradientLayer()
        self.gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        self.gradientLayer.startPoint = self.startPoint
        self.gradientLayer.endPoint = self.endPoint
        self.gradientLayer.frame = self.bounds
        self.layer.addSublayer(self.gradientLayer)
    }


}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                       options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                  return nil
               }

        return prettyJSON
    }
}
