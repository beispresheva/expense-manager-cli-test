//
//  TransactionRepository.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 17.7.26.
//

import Foundation

final class TransactionRepository: TransactionRepositoryProtocol {
    private var transactions: [Transaction] = []
    var count: Int {
        return transactions.count
    }
    
    // functions
    
    func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func getAll() -> [Transaction] {
        return transactions
    }
    
    func findById(by id: UUID) -> Transaction? {
        return transactions.firstMatch { transaction in
            transaction.id == id
        }
    }
    
    func delete(by id: UUID) {
        if let index = transactions.firstIndex(where: { $0.id == id }) {
            transactions.remove(at: index)
        }
        else {
            print("ID does not exist. Cannot delete!")
        }
    }
}
