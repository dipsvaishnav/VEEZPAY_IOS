//
//  HistoryModel.swift
//  VEEZPAY
//
//  Created by DEEPAK on 10/12/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let transactionHistory = try? JSONDecoder().decode(TransactionHistory.self, from: jsonData)

import Foundation

// MARK: - TransactionHistory
struct TransactionHistory: Codable {
    let success: Bool?
    let message: String?
    let results: ResultsTransactionHistory?
}

// MARK: - Results
struct ResultsTransactionHistory: Codable {
    let docs: [Doc]?
    let totalDocs, limit, page, totalPages: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let walletAmount: String?

    enum CodingKeys: String, CodingKey {
        case docs, totalDocs, limit, page, totalPages, pagingCounter, hasPrevPage, hasNextPage
        case walletAmount = "wallet_amount"
    }
}

// MARK: - Doc
struct Doc: Codable {
    let id, transactionID: String?
    let transactionAmount: Int?
    let type, transactionType, currency, senderID: String?
    let senderType, receiverID, receiverType, message: String?
    let status, createdAt, updatedAt: String?
    let senderData, receiverData: [TransactionUserData]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case transactionID = "transaction_id"
        case transactionAmount = "transaction_amount"
        case type
        case transactionType = "transaction_type"
        case currency
        case senderID = "sender_id"
        case senderType = "sender_type"
        case receiverID = "receiver_id"
        case receiverType = "receiver_type"
        case message, status, createdAt, updatedAt
        case senderData = "sender_data"
        case receiverData = "receiver_data"
    }
}

// MARK: - ErDatum
struct TransactionUserData: Codable {
    let id, firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
