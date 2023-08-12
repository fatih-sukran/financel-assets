//
//  Transaction.swift
//  financel assets
//
//  Created by Fatih Şükran on 12.08.2023.
//

import Foundation

struct Transaction: Model {
    var id = UUID()
    var priceId: UUID
    var currencyId: UUID
    var date: Date
    var amount: Double
}
