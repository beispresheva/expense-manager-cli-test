//
//  main.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 16.7.26.
//

import Foundation

let transaction = Transaction(title: "Netflix", amount: 12.99, type: .expense, category: .subscriptions)

print("My Transaction: \n")
print(transaction.title)
print(transaction.amount)
print(transaction.type.rawValue)
print(transaction.category.rawValue)
print(transaction.note ?? "No note provided.")
print(transaction.merchant ?? "No merchant provided.")
