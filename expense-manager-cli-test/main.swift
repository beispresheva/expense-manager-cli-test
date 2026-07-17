//
//  main.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 16.7.26.
//

import Foundation

let repository = TransactionRepository()

let transaction1 = Transaction(title: "Netflix", amount: 12.99, type: .expense, category: .subscriptions)
let transaction2 = Transaction(title: "Groceries", amount: 50.99, type: .expense, category: .food)
let transaction3 = Transaction(title: "Income from freelance", amount: 1499.99, type: .income, category: .other)

repository.add(transaction1)
repository.add(transaction2)
repository.add(transaction3)

// test deletion

repository.delete(by: transaction1.id)

let remainingTransactions = repository.getAll()

if remainingTransactions.isEmpty {
    print("There are not transactions in the repository")
} else {
    print(remainingTransactions.count)
}


