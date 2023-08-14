//
//  financel_assetsApp.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI

@main
struct financel_assetsApp: App {
    
    @StateObject var currencyViewModel = CurrencyViewModel()
    @StateObject var priceViewModel = PriceViewModel()
    @StateObject var transactionViewModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView() {
                TransactionView()
                    .tabItem {
                        Label("Transactions", systemImage: "list.dash")
                    }
                ViewCurriencies()
                    .tabItem {
                        Label("Currencies", systemImage: "list.dash")
                    }
                PriceView()
                    .tabItem {
                        Label("Prices", systemImage: "list.dash")
                    }
                SwiftUIView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
            }
            .environmentObject(currencyViewModel)
            .environmentObject(priceViewModel)
            .environmentObject(transactionViewModel)
        }
    }
}
