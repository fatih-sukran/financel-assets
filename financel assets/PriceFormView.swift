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
//    var priceDto: PriceDTO
    @State private var selectionIndex = 0

    private var formName: String = ""
    @ObservedObject private var priceDataManager = Database.shared.prices
    @ObservedObject private var currencyDataManager = Database.shared.currencies
    @Environment(\.presentationMode) private var presentationMode
    
    init(price: Price?) {
        self._id = State(initialValue: price?.id)
        self._currencyId = State(initialValue: price?.currencyId)
        self._date = State(initialValue: price?.date ?? Date.now)
        self._price = State(initialValue: String(price?.price ?? 0))
//        self._priceDto = PriceDTO(Price(id: UUID(), currencyId: UUID(), date: Date.now, price: 0.0))

        formName = price == nil ? "Add" : "Update"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Currency", selection: $selectionIndex) {
                        ForEach(currencyDataManager.items.indices) { index in
                            Text(currencyDataManager.items[index].name)
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
            price = Price(currencyId: currencyDataManager.items[selectionIndex].id, date: date, price: Double(self.price) ?? 0)
            priceDataManager.add(price)
        } else {
            price = Price(id: id!, currencyId: currencyDataManager.items[selectionIndex].id, date: date, price: Double(self.price) ?? 0)
            priceDataManager.update(price)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct ViewPrices: View {
    
    @ObservedObject private var dataManager = Database.shared.prices
    @EnvironmentObject private var db: Database
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(db.prices.items) { price in
                    NavigationLink(destination: PriceFormView(price: price)) {
                        Text("\(price.date.formatted(date: .numeric, time: .shortened))")
                            .foregroundColor(.accentColor)
                        Text("\(price.currencyId)")
                        Text("\(price.price)")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: dataManager.delete)
            }
            .navigationBarTitle("Prices")
            .navigationBarItems(trailing: NavigationLink(destination: PriceFormView(price: nil)) {
                Image(systemName: "plus")
            })
        }
    }
}

struct PriceFormView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPrices()
    }
}
