//
//  ConsoleMenu.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 17.7.26.
//

import Foundation

enum ConsoleMenu {
    static func showMainMenu() {
        print("""
        
        Personal Expense Manager
        ------------------------
        1. Add income
        2. Add expense
        3. View all transactions
        4. Search transactions
        5. View financial summary
        6. Remove a transaction
        7. Manage monthly budget
        8. View current budget
        9. Exit
        
        """)
    }
}
