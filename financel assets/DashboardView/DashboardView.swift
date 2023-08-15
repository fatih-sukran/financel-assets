//
//  DashboardView.swift
//  financel assets
//
//  Created by Fatih Şükran on 14.08.2023.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var priceViewModel: PriceViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dashboardViewModel.assets, id: \.self) { dashboard in
                    HStack{
                        Text(dashboard.currency.name)
                        Text("\(dashboard.amount)")
                    }
                }
            }
        }.onAppear {
            dashboardViewModel.load(currencies: currencyViewModel.items, prices: priceViewModel.items, transactions: transactionViewModel.items)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
