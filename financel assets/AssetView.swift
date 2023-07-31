//
//  ContentView.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI
import Foundation

let tl = Currency(id: UUID(), name: "TL", symbol: "₺")
let dolar = Currency(id: UUID(), name: "Dolar", symbol: "$")
let altın = Currency(id: UUID(), name: "Altın", symbol: "ALT")
let bitcoin = Currency(id: UUID(), name: "Bitcoin",  symbol: "BTC")
let etherium = Currency(id: UUID(), name: "Etherium", symbol: "ETH")

let assets = [tl, dolar, altın, bitcoin, etherium]

struct SwiftUIView: View {
    var body: some View {
        VStack() {
            Table(assets) {
                TableColumn("Asset", value: \.name)
                TableColumn("Price") { asset in
                    Text("(asset.price)") // Convert Double to String explicitly
                }
                TableColumn("Amount") { asset in
                    Text("(asset.amount)") // Convert Double to String explicitly
                }
            }
            Button("ADD 100 Dolar") {
//                var database = Database()
//                for c in database.datas {
//                    print ("name: (c.name) - amount: (c.amount)")
//                }
//
//                database.save()
            }
        }
    }
}


struct AssetView: View {

    @State var assetName: String
    @State var assetValue: Double

    var body: some View {
        VStack(alignment: .center) {
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
            .frame(width: 500, height: 210)
            .background(Color.cyan)
            .foregroundColor(.cyan)
            .overlay(
                VStack() {
                    HStack() {
                        AssetView(assetName: tl.name, assetValue: calculateTotalTL())
                        AssetView(assetName: dolar.name, assetValue: calculateTotalDolar())
                    }
                    HStack() {
                        AssetView(assetName: altın.name, assetValue: 23.21)
                        AssetView(assetName: bitcoin.name, assetValue: 23.21)
                    }
                }
        ).cornerRadius(41)

    }

    func calculateTotalTL() -> Double {
        var total = 0.0

        for asset in assets {
            if (asset.name == "TL") {
                total += 5
            } else if (asset.name == "Altın") {
                total += 5.0
            } else {
                total += 5
            }
        }

        return total
    }

    func calculateTotalDolar() -> Double {
        var total = 0.0

        for asset in assets {
            if (asset.name == "TL") {
                total += 5
            } else if (asset.name == "Altın") {
                total += 5
            } else {
                total += 5
            }
        }

        return total
    }

    func calculateTotalAltın() -> Double {
        let total = 0.0

//        for asset in assets {
//            if (asset.name == "TL") {
//                total += asset.amount / asset.price
//            }
//        }
        return total
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
