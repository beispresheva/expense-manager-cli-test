//
//  ConsoleApp.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 17.7.26.
//

import Foundation

final class ConsoleApp {
    private let repository: TransactionRepositoryProtocol
    private var budget: Budget?
    private var isRunning = true
    
    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    func run() {
        while isRunning {
            ConsoleMenu.showMainMenu()
            
            let choice = ConsoleInput.readMenuChoice(prompt: "Enter your choice: ", validRange: 1...9)
            
            handleMenuChoice(choice)
        }
    }
    
    private func handleMenuChoice(_ choice: Int) {
        switch choice {
            
        case 1:
            addTransaction(type: .income)
            
        case 2:
            addTransaction(type: .expense)
            
        case 3:
            showAllTransactions()
            
        case 4:
            searchTransactions()
            
        case 5:
            showFinancialSummary()
            
        case 6:
            removeTransaction()
            
        case 7:
            manageBudget()
            
        case 8:
            if let budget {
                showBudgetStatus(for: budget)
            } else {
                print("No monthly budget has been set.")
            }
            
        case 9:
            print("Goodbye!")
            isRunning = false
            
        default :
            break
        }
    }
    
    private func printTransaction(_ transaction: Transaction) {
        print("ID: \(transaction.id)")
        print("Title: \(transaction.title)")
        print("Amount: \(transaction.amount.currencyText)")
        print("Type: \(transaction.type.rawValue)")
        print("Category: \(transaction.category.rawValue)")
        print("Note: \(transaction.note ?? "No note")")
        print("Merchant: \(transaction.merchant ?? "No merchant")")
        print("----------------")
    }
    
    private func addTransaction(type: TransactionType) {
        let title = ConsoleInput.readRequiredText(prompt: "Enter transaction title:")
        
        let amount = ConsoleInput.readPositiveDouble(prompt: "Enter transaction amount:")
        
        let category = chooseCategory()
        
        let note = ConsoleInput.readOptionalText(prompt: "Enter (optional) note:")
        
        let merchant = ConsoleInput.readOptionalText(prompt: "Enter merchant (optional):")
        
        let transaction = Transaction(
            title: title,
            amount: amount,
            type: type,
            category: category,
            note: note,
            merchant: merchant
        )

        repository.add(transaction)

        print("\nTransaction added successfully.")
    }

    private func chooseCategory() -> TransactionCategory {
        print("\nChoose a category:")

            for (index, category) in TransactionCategory.allCases.enumerated() {
                print("\(index + 1). \(category.rawValue)")
            }

            let choice = ConsoleInput.readMenuChoice(
                prompt: "Category:",
                validRange: 1...TransactionCategory.allCases.count
            )

            return TransactionCategory.allCases[choice - 1]
    }
    
    private func showAllTransactions() {
        let transactions = repository.getAll()
        
        if transactions.isEmpty {
            print("No transactions available.")
            return
        }
        
        print("\nAll Transactions")
        print("----------------")

        for transaction in transactions {
            printTransaction(transaction)
        }
    }
    
    private func searchTransactions() {
        let searchText = ConsoleInput.readRequiredText(
            prompt: "Enter title, note or merchant to search:"
        )

        let results = repository.getAll().filter { transaction in
            transaction.title.localizedCaseInsensitiveContains(searchText)
            || transaction.note?.localizedCaseInsensitiveContains(searchText) == true
            || transaction.merchant?.localizedCaseInsensitiveContains(searchText) == true
        }

        if results.isEmpty {
            print("\nNo matching transactions found.")
            return
        }

        print("\nSearch Results")
        print("----------------")

        for transaction in results {
            printTransaction(transaction)
        }
    }
    
    private func removeTransaction() {
        let idText = ConsoleInput.readRequiredText(prompt: "Enter the transaction ID:")

        guard let id = UUID(uuidString: idText) else {
            print("\nInvalid transaction ID.")
            return
        }

        guard let transaction = repository.findById(by: id) else {
            print("\nTransaction not found.")
            return
        }

        print("\nTransaction found:")
        printTransaction(transaction)
        
        repository.delete(by: id)

        print("Transaction removed successfully.")
    }
    
    private func showFinancialSummary() {
        let transactions = repository.getAll()

        let totalIncome = transactions
            .filter { $0.type == .income }
            .reduce(0) { total, transaction in
                total + transaction.amount
            }

        let totalExpenses = transactions
            .filter { $0.type == .expense }
            .reduce(0) { total, transaction in
                total + transaction.amount
            }

        let balance = totalIncome - totalExpenses
        
        let expenses = transactions.filter { $0.type == .expense }

        let highestExpense = expenses.max { first, second in
            first.amount < second.amount
        }

        let averageExpense: Double

        if expenses.isEmpty {
            averageExpense = 0
        } else {
            averageExpense = totalExpenses / Double(expenses.count)
        }
        
        var spendingByCategory: [TransactionCategory: Double] = [:]

        for expense in expenses {
            spendingByCategory[expense.category, default: 0] += expense.amount
        }
        
        let usedCategories = Set(expenses.map { $0.category })

        print("\nFinancial Summary")
        print("-----------------")
        print("Total income: \(totalIncome.currencyText)")
        print("Total expenses: \(totalExpenses.currencyText)")
        print("Balance: \(balance.currencyText)")
        print("Highest expense: \(highestExpense?.amount.currencyText ?? "€0.00")")
        print("Average expense: \(averageExpense.currencyText)")
        
        print("\nSpending by Category")

        if spendingByCategory.isEmpty {
            print("No expense categories found.")
        } else {
            for (category, total) in spendingByCategory {
                print("\(category.rawValue): \(total.currencyText)")
            }
        }
        
        print("\nUnique expense categories used: \(usedCategories.count)")
    }
    
    private func showBudgetStatus(for budget: Budget) {
        let totalExpenses = repository.getAll()
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }

        print("Budget limit: \(budget.limit.currencyText)")
        print("Total expenses: \(totalExpenses.currencyText)")
        
        print(budget.summary(for: totalExpenses))
    }
    
    private func manageBudget() {
        
        let limit = ConsoleInput.readPositiveDouble(prompt: "Enter budget limit:")
        
        budget = Budget(limit: limit)
        
        print("Monthly budget set successfully.")
        
        if let budget {
            showBudgetStatus(for: budget)
        }
    }
}
