//
//  financel_assetsApp.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI

@main
struct financel_assetsApp: App {
    var body: some Scene {
        WindowGroup {
               VStack() {
                   AssetsView2()
                   SwiftUIView()
                   var items = [
                       TodoItem(title: "abc"),
                       TodoItem(title: "def"),
                       TodoItem(title: "ghi")
                   ]
                   CurrencyFormView(viewModel: CurrencyFormViewModel(items: items))
               }
           }
    }
}
