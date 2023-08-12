//
//  PriceFormView.swift
//  financel assets
//
//  Created by Fatih Şükran on 31.07.2023.
//

import SwiftUI

struct PriceDTO {
    var priceId: UUID
    var currencyName: String = ""
    var currencySymbol: String = ""
    var date: Date
    var price: Double
    
    init(_ priceStruct: Price) async {
        priceId = priceStruct.id
        date = priceStruct.date
        price = priceStruct.price
        if let currency = await Database.shared.currencies.getById(priceStruct.currencyId) {
            currencyName = currency.name
            currencySymbol = currency.symbol
        }
    }
}

struct PriceFormView: View {
    @State var id: UUID?
    @State var currencyId: UUID?
    @State var date: Date
    @State var price: String
    @State private var selectionIndex = 0

    private var formName: String = ""
    @ObservedObject private var priceViewModel: PriceViewModel
    @ObservedObject private var currencyViewModel: CurrencyViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    init(price: Price? = nil, priceViewModel: PriceViewModel, currencyViewModel: CurrencyViewModel) {
        self._id = State(initialValue: price?.id)
        self._currencyId = State(initialValue: price?.currencyId)
        self._date = State(initialValue: price?.date ?? Date.now)
        self._price = State(initialValue: String(price?.price ?? 0))
        self.priceViewModel = priceViewModel
        self.currencyViewModel = currencyViewModel

        formName = price == nil ? "Add" : "Update"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Currency", selection: $selectionIndex) {
                        ForEach(currencyViewModel.items.indices) { index in
                            Text(currencyViewModel.items[index].name)
                        }
                    }
                    DatePicker("Date", selection: $date)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("\(formName) Price") {
                        onSave()
                    }
                }
            }
            .navigationBarTitle("\(formName) Price")
        }
    }
    
    private func onSave() {
        var price: Price
        
        if id == nil {
            price = Price(currencyId: currencyViewModel.items[selectionIndex].id, date: date, price: Double(self.price) ?? 0)
            priceViewModel.add(price)
        } else {
            price = Price(id: id!, currencyId: currencyViewModel.items[selectionIndex].id, date: date, price: Double(self.price) ?? 0)
            priceViewModel.update(price)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct PriceView: View {
    
    @ObservedObject var priceViewModel: PriceViewModel
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(priceViewModel.items) { price in
                    NavigationLink(destination:PriceFormView(
                        price: price,
                        priceViewModel: priceViewModel,
                        currencyViewModel: currencyViewModel)) {
                        Text("\(price.date.formatted(date: .numeric, time: .shortened))")
                            .foregroundColor(.accentColor)
                        Text("\(price.currencyId)")
                        Text("\(price.price)")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: priceViewModel.delete)
            }
            .navigationBarTitle("Prices")
            .navigationBarItems(trailing: NavigationLink(destination: PriceFormView(
                priceViewModel: priceViewModel,
                currencyViewModel: currencyViewModel)) {
                Image(systemName: "plus")
            })
        }
    }
}

//struct PriceFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPrices()
//    }
//}
