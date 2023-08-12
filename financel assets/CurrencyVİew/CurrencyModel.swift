//
//  Currency.swift
//  financel assets
//
//  Created by Fatih Şükran on 12.08.2023.
//

import Foundation

struct Currency: Model {
    var id = UUID()
    var name: String
    var symbol: String
}
