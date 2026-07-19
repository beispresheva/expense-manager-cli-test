//
//  main.swift
//  expense-manager-cli-test
//
//  Created by Beis Presheva on 16.7.26.
//

import Foundation

let repository = TransactionRepository()
let app = ConsoleApp(repository: repository)
app.run()
