//
//  Transaction.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 16.7.26.
//

import Foundation

struct Transaction {
    let id: UUID
    let title: String
    let amount: Double
    let type: TransactionType
    let category: TransactionCategory
    let note: String?
    let merchant: String?
    
    init(id: UUID = UUID(), title: String, amount: Double, type: TransactionType, category: TransactionCategory, note: String? = nil, merchant: String? = nil) {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.category = category
        self.note = note
        self.merchant = merchant
    }
}
