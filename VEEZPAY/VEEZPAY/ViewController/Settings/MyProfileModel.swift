//
//  MyProfileModel.swift
//  VEEZPAY
//
//  Created by DEEPAK on 26/11/23.
//

import Foundation
// MARK: - GetMyProfile
struct GetMyProfile: Codable {
    let success: Bool?
    let message: String?
    let results: ResultsGetMyProfile?
}

// MARK: - Results
struct ResultsGetMyProfile: Codable {
    let status: String?
    let countryCode: Int?
    let hasNewNotification: Bool?
    let referredByCode: String?
    let notifications: Bool?
    let deviceID, id, createdAt, lastName: String?
    let kycStatus, identityCard, passport, updatedAt: String?
    let deviceToken, email,address, walletAmount, mobile: String?
    let referralCode, profilePic, firstName, deviceType: String?
    let bonusCredit: Bool?

    enum CodingKeys: String, CodingKey {
        case status
        case countryCode = "country_code"
        case hasNewNotification
        case referredByCode = "referred_by_code"
        case notifications
        case deviceID = "device_id"
        case id = "_id"
        case createdAt
        case lastName = "last_name"
        case kycStatus = "kyc_status"
        case identityCard = "identity_card"
        case passport, updatedAt
        case deviceToken = "device_token"
        case email
        case walletAmount = "wallet_amount"
        case mobile
        case address
        case referralCode = "referral_code"
        case profilePic = "profile_pic"
        case firstName = "first_name"
        case deviceType = "device_type"
        case bonusCredit = "bonus_credit"
    }
}

struct UpdateMyProfile: Codable {
    let success: Bool?
    let message: String?
}

// MARK: - AddMoney
struct AddMoney: Codable {
    let success: Bool?
    let message: String?
    let results: ResultsAddMoney?
}

// MARK: - Results
struct ResultsAddMoney: Codable {
    let walletAmount: String?

    enum CodingKeys: String, CodingKey {
        case walletAmount = "wallet_amount"
    }
}
