//
//  financel_assetsApp.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI

@main
struct financel_assetsApp: App {
    
    @StateObject var db = Database()
    
    var body: some Scene {
        WindowGroup {
            TabView() {
                ViewCurriencies()
                    .tabItem {
                        Label("Currencies", systemImage: "list.dash")
                    }
                ViewPrices()
                    .tabItem {
                        Label("Prices", systemImage: "list.dash")
                    }
                SwiftUIView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
            }
            .environmentObject(db)
        }
    }
}
