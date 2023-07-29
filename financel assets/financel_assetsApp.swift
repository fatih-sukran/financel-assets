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
            TabView() {
                CurrencyFormView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                    AssetsView2()
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }
                
                    SwiftUIView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                    
            }
           }
    }
}
