//
//  PriceViewModel.swift
//  financel assets
//
//  Created by Fatih Şükran on 12.08.2023.
//

import Foundation

final class PriceViewModel: IDataManager<Price> {
    
    override func add(_ item: Price) {
        if let index = items.firstIndex(where: {item.currencyId == $0.currencyId && areDatesEqual(date1: item.date, date2: $0.date)}) {
            items[index].price = item.price
        } else {
            add(item)
        }
    }
}
