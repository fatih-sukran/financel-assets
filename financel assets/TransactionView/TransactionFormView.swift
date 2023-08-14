//
//  TransactionFormView.swift
//  financel assets
//
//  Created by Fatih Şükran on 14.08.2023.
//

import SwiftUI

struct TransactionFormView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @EnvironmentObject var priceViewModel: PriceViewModel
    
    @State private var selectionIndex = 0
    @State private var date = Date.now
    @State private var price = "0.0"
    @State private var amount = "0"
    
    private var formName = "Add"
    private var transaction: Transaction?
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(_ transaction: Transaction? = nil) {
        self.transaction = transaction
        if transaction != nil {
            self.formName = "Update"
        }
    }
    
    private func load() {
        if let transaction = transaction {
            let price = priceViewModel.getById(transaction.priceId)!
            let currency = currencyViewModel.getById(transaction.currencyId)!
            
            self.date = transaction.date
            self.price = String(price.price)
            self.amount = String(transaction.amount)
            self.selectionIndex = currencyViewModel.items.firstIndex(of: currency) ?? 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    Picker("Currency", selection: $selectionIndex) {
                        ForEach(0..<currencyViewModel.items.count, id: \.self) { index in
                            Text(currencyViewModel.items[index].name)
                        }
                    }
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("\(formName) Price") {
                        onSave()
                    }
                }
            }
        }
        .onAppear(perform: load)
    }
    
    private func onSave() {
        let currency = currencyViewModel.items[selectionIndex]
        let amount = Double(amount) ?? 0
        let price = Double(price) ?? 0
        
        if transaction == nil {
            let price = Price(currencyId: currencyViewModel.items[selectionIndex].id, date: date, price: price)
            priceViewModel.add(price)
            
            let transaction = Transaction(priceId: price.id, currencyId: currency.id, date: date, amount: amount)
            transactionViewModel.add(transaction)
        } else {
            let priceModel = priceViewModel.getById(transaction!.priceId)!
            priceViewModel.delete(priceModel)
            
            let newPriceModel = Price(currencyId: currency.id, date: date, price: price)
            priceViewModel.add(newPriceModel)
            
            if var transaction = transaction {
                transaction.date = date
                transaction.priceId = newPriceModel.id
                transaction.amount = amount
                transaction.currencyId = currency.id
                
                transactionViewModel.update(transaction)
            }
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct TransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFormView()
    }
}
