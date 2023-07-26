//
//  ContentView.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI
import Foundation

struct Currency : Identifiable{
    let id: UUID
    
    var name: String
    var price: Double
    var amount: Double
    var symbol: String
}

let dolar = Currency(id: UUID(), name: "Dolar", price: 1,amount: 0, symbol: "$")
let altın = Currency(id: UUID(), name: "Altın", price: 1950, amount: 0, symbol: "ALT")
let bitcoin = Currency(id: UUID(), name: "Bitcoin", price: 29250, amount: 0, symbol: "BTC")
let etherium = Currency(id: UUID(), name: "Etherium", price: 1890, amount: 0, symbol: "ETH")

let assets = [dolar, altın, bitcoin, etherium]

struct SwiftUIView: View {
    var body: some View {
        
        VStack(alignment: HorizontalAlignment.leading) {
            ForEach(assets) { asset in
                HStack() {
                    Text(asset.name)
                        .font(Font.title)
                    Text(asset.amount.formatted())
                        .font(Font.title)
                    Text(asset.symbol)
                        .font(Font.title)
                }
            }
        }
    }
}


struct AssetView: View {
    
    @State var assetName: String
    @State var assetValue: Double
    
    var body: some View {
        VStack {
            Capsule()
                .background(Color.blue)
                .frame(width: 210, height: 81)
                .foregroundColor(.gray)
                .overlay(
                    HStack() {
                        Text(assetName)
                            .foregroundColor(.white)
                            .bold()
                            .font(.largeTitle)
                        Text(assetValue.formatted())
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                )
                
        }
        .padding()
    }
}

struct AssetsView2: View {
    var body:  some View {
        Rectangle()
            .background(Color.cyan)
            .foregroundColor(.cyan)
            .overlay(
                VStack() {
                    HStack() {
                        AssetView(assetName: "Dolar", assetValue: 23.21)
                        AssetView(assetName: "Altın", assetValue: 23.21)
                    }
                    HStack() {
                        AssetView(assetName: "BTC", assetValue: 23.21)
                        AssetView(assetName: "ETH", assetValue: 23.21)
                    }
                }
        ).cornerRadius(81)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            AssetsView2()
            SwiftUIView()
        }
    }
}
