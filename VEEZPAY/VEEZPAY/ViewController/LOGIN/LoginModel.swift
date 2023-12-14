//
//  LoginModel.swift
//  VEEZPAY
//
//  Created by DEEPAK on 15/11/23.
//

import Foundation
// MARK: - GetLoginData
struct GetLoginData: Codable {
    let success: Bool?
    let message: String?
    let results: LoginResults?
}

// MARK: - Results
struct LoginResults: Codable {
    let address, status: String?
    let countryCode: Int?
    let referredByCode: String?
    let notifications: Bool?
    let refreshToken, id: String?
    let isMobileVerified: Int?
    let lastName, kycStatus, createdAt: String?
    let identityCardBack: String?
    let type, updatedAt: String?
    let identityCardFront: String?
    let token, email, walletAmount: String?
    let accountBlock: Bool?
    let mobile, referralCode, role: String?
    let forceLogout: Bool?
    let isEmailVerified: Int?
    let firstName: String?
    let profilePic: String?
    let passwordAttempts: Int?
    let bonusCredit: Bool?

    enum CodingKeys: String, CodingKey {
        case address, status
        case countryCode = "country_code"
        case referredByCode = "referred_by_code"
        case notifications
        case refreshToken = "refresh_token"
        case id = "_id"
        case isMobileVerified = "is_mobile_verified"
        case lastName = "last_name"
        case kycStatus = "kyc_status"
        case createdAt
        case identityCardBack = "identity_card_back"
        case type, updatedAt
        case identityCardFront = "identity_card_front"
        case token, email
        case walletAmount = "wallet_amount"
        case accountBlock, mobile
        case referralCode = "referral_code"
        case role, forceLogout
        case isEmailVerified = "is_email_verified"
        case firstName = "first_name"
        case profilePic = "profile_pic"
        case passwordAttempts = "PasswordAttempts"
        case bonusCredit = "bonus_credit"
    }
}
