//
//  BudgetReport.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 19.7.26.
//

import Foundation

struct BudgetReport {
    let totalExpenses: Double
    let percentageUsed: Double
    let remainingAmount: Double
    let exceededAmount: Double
    let status: BudgetStatus
}
