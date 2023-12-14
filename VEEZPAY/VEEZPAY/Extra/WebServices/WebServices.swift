//
//  WebServices.swift
//  VEEZPAY
//
//  Created by DEEPAK on 31/10/23.
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

enum NetworkingErrors: Error {
    case errorParsingJSON
    case badURL
    case noInternetConnection
    case dataReturnedNil
    case returnedError(Error)
    case invalidStatusCode(Int)
    case customError(String)
    case Unauthorized
}

class WebServices:NSObject{
    var host: String {
        return "http://65.2.170.74:8022/v1/"
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "X-Access-Token":"+z8vmLZECUOrIgn8T4f16ARO9t9FDWJAQ92L6aMxABc=",
                "language":"en",
                "Authorization":"Bearer \(Retrive(UDKey.kUserToken))"
        ]
    }

    static let shared = WebServices()
    func request<T: Codable>(type: T.Type,APIPath:Endpoint, info:[String : Any]?, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: host + APIPath.rawValue.0) else {
            completionHandler(.failure(NetworkingErrors.badURL))
            return
        }
        print(url)
        if Connectivity.isConnectedToInternet()
        {
            ProgresShow()
            var request = URLRequest(url: url)
            request.httpMethod = APIPath.rawValue.1
            request.allHTTPHeaderFields = headers
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            
            if let parameters = info {
                do {
                    print(parameters)
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    completionHandler(.failure(error))
                    return
                }
            }
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    DispatchQueue.main.async{
                        self.ProgressHide()
                        AlertMessage("Error", msg: "No Internet Connection!☹")
                    }
                    completionHandler(.failure(error))
                    
                    return
                }
                let response = response as? HTTPURLResponse
                guard response?.statusCode != 401 else {
                    DispatchQueue.main.async{
                        self.ProgressHide()
                        let scene = UIApplication.shared.connectedScenes.first
                        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                            sd.LogoutFromApp()
                        }
                        
                    }
                    
                    return
                }
                if let data = data {
                    do {
                        
                        DispatchQueue.main.async{
                            print("JSON Response",data.prettyPrintedJSONString as Any)
                            self.ProgressHide()
                        }
                        completionHandler(.success(try JSONDecoder().decode(type, from: data)))
                    } catch {
                        DispatchQueue.main.async{
                            self.ProgressHide()
                            AlertMessage("Error", msg:error.localizedDescription)
                        }
                        completionHandler(.failure(error))
                        return
                    }
                }
            })
            
            dataTask.resume()
        }
        else
        {
            AlertMessage("Error", msg:"Internet not available, Cross check your internet connectivity and try again")
        }
    }
    func requestUploadImage<T: Codable>(type: T.Type,APIPath:Endpoint, Method:Alamofire.HTTPMethod, info:[String : Any]?, completionHandler: @escaping (Result<T, Error>) -> Void){
        
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data",
                   "Authorization":"Bearer \(Retrive(UDKey.kUserToken))"]
        guard let url = URL(string: host + APIPath.rawValue.0) else {
            // completionHandler(.failure(NetworkingErrors.badURL))
            return
        }
        print(url)
        if Connectivity.isConnectedToInternet()
        {
            ProgresShow()
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in info! {
                    if let temp = value as? UIImage {
                        guard let imgData = temp.jpegData(compressionQuality: 1) else { return }
                        multipartFormData.append(imgData, withName: key, fileName:"image.jpeg", mimeType: "image/jpeg")
                    }
                    else{
                        multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                }
                
            },
                      to: url,
                      method:Method,
                      headers: headers).response{ response in
                if let data = response.data {
                    do {
                        
                        DispatchQueue.main.async{
                            print("JSON Response",data.prettyPrintedJSONString as Any)
                            self.ProgressHide()
                        }
                        completionHandler(.success(try JSONDecoder().decode(type, from: data)))
                    } catch {
                        DispatchQueue.main.async{
                            self.ProgressHide()
                            AlertMessage("Error", msg:error.localizedDescription)
                        }
                        completionHandler(.failure(error))
                        return
                    }
                }
            }
        }
        else
        {
            
            AlertMessage("Error", msg:"Internet not available, Cross check your internet connectivity and try again")
        }
    }

    func ProgresShow()
    {

        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setRingThickness(5.0)
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.1764705882, green: 0.5450980392, blue: 1, alpha: 1))
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()

    }
    func ProgressHide()
    {
        SVProgressHUD.dismiss()
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum Endpoint:RawRepresentable {
    init?(rawValue: (String, String)) {
        switch rawValue {
        default: return nil
        }
    }
        case Login
        case Register
        case VerifyOTP
        case ResendOTP
        case Setsecuritypin
        case MyProfile
        case ForgotPassword
        case ForgotPasswordVerify
        case RestPassword
        case UpdateProfile
        case UpdateProfileKYC
        case CustomerQrCode
        case AddMoney
        case SearchuserMobile
        case TransferMoneyMobile
        case TransactionHistory
    
        var rawValue: (String, String) {
            switch self {
            case .Login:
                return ("user/login", HTTPMethod.post.rawValue)
            case .Register:
                return ("user/signup", HTTPMethod.post.rawValue)
            case.VerifyOTP:
                return ("user/verify-email-mobile", HTTPMethod.post.rawValue)
            case.ResendOTP:
                return ("user/resend-otp", HTTPMethod.post.rawValue)
            case.Setsecuritypin:
                return ("user/set-security-pin", HTTPMethod.post.rawValue)
            case.MyProfile:
                return ("user/my-profile", HTTPMethod.get.rawValue)
            case.ForgotPassword:
                return ("user/forgot-password", HTTPMethod.post.rawValue)
            case.ForgotPasswordVerify:
                return ("user/forgot-password-verify-otp", HTTPMethod.post.rawValue)
            case.RestPassword:
                return ("user/reset-password", HTTPMethod.post.rawValue)
            case.UpdateProfile:
                return("user/update-profile",HTTPMethod.put.rawValue)
            case.UpdateProfileKYC:
                return("user/update-profile-kyc",HTTPMethod.put.rawValue)
            case.CustomerQrCode:
                return("user/customer-qr-code",HTTPMethod.get.rawValue)
            case.AddMoney:
                return("user/wallet/add-money",HTTPMethod.post.rawValue)
            case.SearchuserMobile:
                return("user/wallet/searchUser",HTTPMethod.put.rawValue)
            case.TransferMoneyMobile:
                return("user/wallet/transfer/mobile",HTTPMethod.post.rawValue)
            case.TransactionHistory:
                return("user/wallet/statement",HTTPMethod.get.rawValue)
            }
        }
    
}



