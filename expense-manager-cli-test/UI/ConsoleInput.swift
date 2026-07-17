//
//  Console Input.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 17.7.26.
//

import Foundation

enum ConsoleInput {
    static func readRequiredText(prompt: String) -> String {
        while true {
            print(prompt, terminator: " ")
            
            if let input = readLine(), !input.isEmpty, !input.allSatisfy(\.isWhitespace) {
                
                let cleanedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if !cleanedInput.isEmpty {
                    return cleanedInput
                }
                
                return input
            }
            
            print("Input cannot be empty.")
        }
    }
    
    static func readOptionalText(prompt: String) -> String? {
        print(prompt, terminator: " ")

        guard let input = readLine(), !input.allSatisfy(\.isWhitespace) else {
            return nil
        }

        let cleanedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)

        return cleanedInput.isEmpty ? nil : cleanedInput
    }
    
    static func readPositiveDouble(prompt: String) -> Double {
        while true {
            print(prompt, terminator: " ")

            if let input = readLine(),
               !input.isEmpty,
               !input.allSatisfy(\.isWhitespace),
               let amount = Double(input),
               amount > 0 {
                return amount
            }

            print("Enter a valid amount greater than 0.")
        }
    }
    
    static func readMenuChoice(prompt: String, validRange: ClosedRange<Int>) -> Int {
        while true {
            print(prompt, terminator: " ")
            
            if let input = readLine(),
               let choice = Int(input),
               validRange.contains(choice) {
                return choice
            }
            
            print("Enter a number between \(validRange.lowerBound) to \(validRange.upperBound).")
        }
    }
}
