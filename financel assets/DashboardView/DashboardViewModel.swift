//
//  DashboardModelView.swift
//  financel assets
//
//  Created by Fatih Şükran on 14.08.2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var assets: [Dashboard] = []
    
    func load(currencies: [Currency], prices: [Price], transactions: [Transaction]) {
        assets = []
        for currency in currencies {
            var amount = 0.0
            
            if (prices.isEmpty){
                continue
            }
            let price = prices.sorted(by: {$0.date > $1.date})[0]

            for transaction in transactions {
                if transaction.currencyId == currency.id {
                    amount += transaction.amount
                }
            }
            let dashboard = Dashboard(currency: currency, price: price, amount: amount)
            assets.append(dashboard)
        }
    }
}
