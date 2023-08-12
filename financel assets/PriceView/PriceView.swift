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

struct PriceFormView: View {
    @State var id: UUID?
    @State var currencyId: UUID?
    @State var date: Date
    @State var price: String
    @State private var selectionIndex = 0

    private var formName: String = ""
    @EnvironmentObject var priceViewModel: PriceViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    init(_ price: Price? = nil) {
        self._id = State(initialValue: price?.id)
        self._currencyId = State(initialValue: price?.currencyId)
        self._date = State(initialValue: price?.date ?? Date.now)
        self._price = State(initialValue: String(price?.price ?? 0))

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

//struct PriceFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPrices()
//    }
//}
