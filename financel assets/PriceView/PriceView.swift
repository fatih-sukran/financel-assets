//
//  PriceFormView.swift
//  financel assets
//
//  Created by Fatih Şükran on 31.07.2023.
//

import SwiftUI

struct PriceView: View {
    
    @EnvironmentObject var priceViewModel: PriceViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(priceViewModel.items) { price in
                    NavigationLink(destination: PriceFormView(price)) {
                        let currency = currencyViewModel.getById(price.currencyId)
                        
                        Text("\(currency?.name ?? "")")
                            .foregroundColor(.accentColor)
                        Text("\(price.date.formatted(date: .numeric, time: .shortened))")
                        Spacer()
                        Text("\(price.price, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: priceViewModel.delete)
            }
            .navigationBarTitle("Prices")
            .navigationBarItems(trailing: NavigationLink(destination: PriceFormView()) {
                Image(systemName: "plus")
            })
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView()
    }
}
