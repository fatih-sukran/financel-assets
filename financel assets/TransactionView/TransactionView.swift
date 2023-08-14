//
//  TransactionView.swift
//  financel assets
//
//  Created by Fatih Şükran on 12.08.2023.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @EnvironmentObject var priceViewModel: PriceViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(transactionViewModel.items) {transaction in
                    NavigationLink(destination: TransactionFormView(transaction)) {
                        var currency = getCurrency(transaction.currencyId)
                        
                        Text("\(transaction.amount) \(currency.symbol)")
                            .foregroundColor(.accentColor)
                        Text("\(transaction.date)")
                    }
                }
            }
            .navigationBarTitle("Transactions")
            .navigationBarItems(trailing: NavigationLink(destination: TransactionFormView()) {
                Image(systemName: "plus")
            })
        }
    }
    
    func getCurrency(_ id: UUID) -> Currency {
        return currencyViewModel.getById(id).unsafelyUnwrapped
    }
    
    func getPrice(_ id: UUID) -> Price {
        return priceViewModel.getById(id).unsafelyUnwrapped
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
