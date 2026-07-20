//
//  Budget.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 19.7.26.
//

import Foundation

struct Budget {
    let limit: Double
    
    func status(for totalExpenses: Double) -> BudgetStatus {
        let usagePercentage = usagePercentage(for: totalExpenses)
        
        if totalExpenses > limit {
            return .exceeded
        } else if usagePercentage >= 80 {
            return .warning
        } else {
            return .safe
        }
    }
    
    func usagePercentage(for totalExpenses: Double) -> Double {
        return (totalExpenses / limit) * 100
    }
    
    func remainingAmount(for totalExpenses: Double) -> Double {
        return limit - totalExpenses
    }
    
    func exceededAmount(for totalExpenses: Double) -> Double {
        return max(totalExpenses - limit, 0)
    }
    
    func summary(for totalExpenses: Double) -> String {
        let report = createReport(for: totalExpenses)

        switch report.status {
        case .safe:
            return """
            Budget used: \(report.percentageUsed.percentageText)
            Remaining budget: \(report.remainingAmount.currencyText)
            """

        case .warning:
            return """
            Budget used: \(report.percentageUsed.percentageText)
            Remaining budget: \(report.remainingAmount.currencyText)
            Warning: You are close to your monthly budget limit.
            """

        case .exceeded:
            return """
            Budget used: \(report.percentageUsed.percentageText)
            Budget exceeded by: \(report.exceededAmount.currencyText)
            """
        }
    }
    
    func createReport(for totalExpenses: Double) -> BudgetReport {
        return BudgetReport(
            totalExpenses: totalExpenses,
            percentageUsed: usagePercentage(for: totalExpenses),
            remainingAmount: remainingAmount(for: totalExpenses),
            exceededAmount: exceededAmount(for: totalExpenses),
            status: status(for: totalExpenses))
    }
}
