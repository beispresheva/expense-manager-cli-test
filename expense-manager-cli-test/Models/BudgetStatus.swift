//
//  BudgetStatus.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 19.7.26.
//

import Foundation

enum BudgetStatus {
    case safe
    case warning
    case exceeded
    
    var message: String {
        switch self {
        case .safe:
            return "Your spending is within safe range."
            
        case .warning:
            return "You are close to your monthly budget limit."
            
        case .exceeded:
            return "You have exceeded your monthly budget."
        }
    }
}
