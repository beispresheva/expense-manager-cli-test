//
//  TransactionRepositoryProtocol.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 19.7.26.
//

import Foundation

protocol TransactionRepositoryProtocol {
    var count: Int { get }
    
    func add(_ transaction: Transaction)
    func getAll() -> [Transaction]
    func findById(by id: UUID) -> Transaction?
    func delete(by id: UUID)
}
