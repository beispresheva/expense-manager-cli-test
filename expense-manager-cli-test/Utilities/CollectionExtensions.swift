//
//  CollectionExtensions.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 20.7.26.
//

import Foundation

extension Array {
    func firstMatch(where condition: (Element) -> Bool) -> Element? {
        for item in self {
            if condition(item) {
                return item
            }
        }
        
        return nil
    }
}
