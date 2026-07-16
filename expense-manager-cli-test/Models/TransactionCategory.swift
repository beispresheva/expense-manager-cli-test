//
//  TransactionCategory.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 16.7.26.
//

import Foundation

enum TransactionCategory: String, CaseIterable {
    case salary = "Salary"
    case food = "Food"
    case transport = "Transport"
    case shopping = "Shopping"
    case bills = "Bills"
    case entertainment = "Entertainment"
    case education = "Education"
    case subscriptions = "Subscriptions"
    case other = "Other"
}
