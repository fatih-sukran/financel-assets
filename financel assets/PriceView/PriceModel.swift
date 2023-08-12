//
//  PriceModel.swift
//  financel assets
//
//  Created by Fatih Şükran on 12.08.2023.
//

import Foundation

struct Price: Model {
    var id = UUID()
    var currencyId: UUID
    var date: Date
    var price: Double
}
