//
//  ConsoleApp.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 17.7.26.
//

import Foundation

final class ConsoleApp {
    private var isRunning = true
    
    func run() {
        while isRunning {
            ConsoleMenu.showMainMenu()
            
            let choice = ConsoleInput.readMenuChoice(prompt: "Enter your choice: ", validRange: 1...7)
            
            handleMenuChoice(choice)
        }
    }
    
    private func handleMenuChoice(_ choice: Int) {
        switch choice {
            
        case 1:
            print("Add income selected")
            
        case 2:
            print("Add expense selected")
            
        case 3:
            print("View all transactions selected")
            
        case 4:
            print("Search transactions selected")
            
        case 5:
            print("View financial summary selected")
            
        case 6:
            print("Remove a transaction selected")
            
        case 7:
            print("Goodbye!")
            isRunning = false
            
        default :
            break
        }
    }

    
}
