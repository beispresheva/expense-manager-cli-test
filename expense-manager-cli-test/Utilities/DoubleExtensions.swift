//
//  DoubleExtensions.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 18.7.26.
//

import Foundation

extension Double {
    var currencyText: String {
        String(format: "€%.2f", self)
    }
}
