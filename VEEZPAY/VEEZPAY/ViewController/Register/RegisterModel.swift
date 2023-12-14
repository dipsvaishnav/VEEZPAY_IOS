//
//  RegisterModel.swift
//  VEEZPAY
//
//  Created by DEEPAK on 21/11/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerModel = try? JSONDecoder().decode(RegisterModel.self, from: jsonData)

import Foundation
import UIKit
// MARK: - RegisterModel
struct RegisterModel: Codable {
    let success: Bool?
    let message: String?
    let results: ResultsRegister?
}

// MARK: - Results
struct ResultsRegister: Codable {
    let bonusCredit: Bool?
    let passwordAttempts: Int?
    let status: String?
    let v, countryCode: Int?
    let referredByCode: String?
    let notifications: Bool?
    let deviceID, id, refreshToken: String?
    let isMobileVerified: Int?
    let lastName, kycStatus, createdAt: String?
    let identityCardBack: String?
    let type, updatedAt, deviceToken: String?
    let identityCardFront: String?
    let token, email: String?
    let walletAmount: Int?
    let mobile: String?
    let accountBlock: Bool?
    let referralCode, role: String?
    let forceLogout: Bool?
    let isEmailVerified: Int?
    let firstName: String?
    let profilePic: String?
    let address, deviceType: String?

    enum CodingKeys: String, CodingKey {
        case bonusCredit = "bonus_credit"
        case passwordAttempts = "PasswordAttempts"
        case status
        case v = "__v"
        case countryCode = "country_code"
        case referredByCode = "referred_by_code"
        case notifications
        case deviceID = "device_id"
        case id = "_id"
        case refreshToken = "refresh_token"
        case isMobileVerified = "is_mobile_verified"
        case lastName = "last_name"
        case kycStatus = "kyc_status"
        case createdAt
        case identityCardBack = "identity_card_back"
        case type, updatedAt
        case deviceToken = "device_token"
        case identityCardFront = "identity_card_front"
        case token, email
        case walletAmount = "wallet_amount"
        case mobile, accountBlock
        case referralCode = "referral_code"
        case role, forceLogout
        case isEmailVerified = "is_email_verified"
        case firstName = "first_name"
        case profilePic = "profile_pic"
        case address
        case deviceType = "device_type"
    }
}

// MARK: - GetMyProfile
struct ForgotPasswordVerifyModel: Codable {
    let success: Bool?
    let message: String?
    let results: ResultsForgotPasswordVerifyModel?
}

// MARK: - Results
struct ResultsForgotPasswordVerifyModel: Codable {
    let id: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}

// MARK:- Structure for User Defaults Key
struct UDKey {

    static let kLogIn_UserName                =   "kLogIn_UserName"
    static let kLogIn_Password                =   "kLogIn_Password"

    static let kLoginAgreementAccepted        =   "kLoginAgreementAccepted"

    static let kUserProfileInfo               =   "kUserProfileInfo"
    static let kUser_ID                       =    "kUser_ID"
    static let kUser_ProfilePic               =    "kUser_ProfilePic"

    static let kProUserInfo                   =   "kProUserInfo"

    static let kUserToken                     =   "kUserToken"
    static let kUserDeviceToken               =   "kUserDeviceToken"
    static let kUserFCMToken                  =   "kUserFCMToken"

    static let kGlobalSettingsInfo            =   "kGlobalSettingsInfo"
    static let kAccountSettings               =   "kAccountSettings"
    static let kFirstTimeLaunch                      =    "kFirstTimeLaunch"

}
