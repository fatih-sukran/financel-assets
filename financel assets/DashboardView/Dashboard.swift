//
//  Dashboard.swift
//  financel assets
//
//  Created by Fatih Şükran on 14.08.2023.
//

import Foundation

struct Dashboard: Model {
    var id = UUID()
    var currency: Currency
    var price: Price
    var amount: Double
}
