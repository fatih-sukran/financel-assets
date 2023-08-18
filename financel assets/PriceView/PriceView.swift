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
    @State private var selectionFilter = "All"
    @State private var items: [Price]?
    
    var body: some View {
        NavigationStack {
            Picker("Filter", selection: $selectionFilter) {
                Text("All").tag("All")
                ForEach(currencyViewModel.items) { currency in
                    Text(currency.name).tag(currency.id.uuidString)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: selectionFilter) { newValue in
                filter()
            }
            
            List {
                ForEach(items ?? priceViewModel.items) { price in
                    NavigationLink(destination: PriceFormView(price)) {
                        let currency = currencyViewModel.getById(price.currencyId)
                        
                        Text("\(currency?.name ?? "")")
                            .foregroundColor(.accentColor)
                        Text("\(price.date.formatted(date: .numeric, time: .omitted))")
                        Spacer()
                        let specifier =  "%.\(currency?.digit ?? 2)f"
                        Text("\(price.price, specifier: specifier)")
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
    
    private func filter() {
        if selectionFilter == "All" {
            items = nil
            priceViewModel.items.sort(by: {$0.date > $1.date})
            priceViewModel.save()
        } else {
            items = priceViewModel.items.filter { $0.currencyId.uuidString == selectionFilter }
            items!.sort(by: {$0.date > $1.date})
        }
    }
}

struct PriceView2: View {
    
    @EnvironmentObject var priceViewModel: PriceViewModel2
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @State private var selectionFilter = "All"
    @State private var items: [SymbolPrice]?
    
    var body: some View {
        NavigationStack {
            Picker("Filter", selection: $selectionFilter) {
                Text("All").tag("All")
                ForEach(currencyViewModel.items) { currency in
                    Text(currency.name).tag(currency.id.uuidString)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: selectionFilter) { newValue in
                filter()
            }
            
            List {
                for currency in currencyViewModel.items {
                ForEach(items ?? ) { price in
                    NavigationLink(destination: PriceFormView(price)) {
                        let currency = currencyViewModel.getById(price.currencyId)
                        
                        Text("\(currency?.name ?? "")")
                            .foregroundColor(.accentColor)
                        Text("\(price.date.formatted(date: .numeric, time: .omitted))")
                        Spacer()
                        let specifier =  "%.\(currency?.digit ?? 2)f"
                        Text("\(price.price, specifier: specifier)")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: priceViewModel.delete)}
            }
            .navigationBarTitle("Prices")
            .navigationBarItems(trailing: NavigationLink(destination: PriceFormView()) {
                Image(systemName: "plus")
            })
        }
    }
    
    private func filter() {
        if selectionFilter == "All" {
            items = nil
            priceViewModel.items.sort(by: {$0.date > $1.date})
            priceViewModel.save()
        } else {
            items = priceViewModel.items.filter { $0.currencyId.uuidString == selectionFilter }
            items!.sort(by: {$0.date > $1.date})
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView()
    }
}
