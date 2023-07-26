////
////  SwiftUIView.swift
////  financel assets
////
////  Created by Fatih Şükran on 26.07.2023.
////
//
//import SwiftUI
//
//struct Asset : Identifiable{
//    let id: UUID
//
//    var name: String
//    var price: Double
//    var amount: Double
//    var symbol: String
//}
//
//var dolar = Asset(id: UUID(), name: "Dolar", price: 1,amount: 0, symbol: "$")
//var altın = Asset(id: UUID(), name: "Altın", price: 1950, amount: 0, symbol: "ALT")
//var bitcoin = Asset(id: UUID(), name: "Bitcoin", price: 29250, amount: 0, symbol: "BTC")
//var etherium = Asset(id: UUID(), name: "Etherium", price: 1890, amount: 0, symbol: "ETH")
//
//var assets = [dolar, altın, bitcoin, etherium]
//
//struct SwiftUIView: View {
//    var body: some View {
//
//        VStack(alignment: HorizontalAlignment.leading) {
//            ForEach(assets) { asset in
//                HStack() {
//                    Text(asset.name)
//                        .font(Font.title)
//                    Text(asset.amount.formatted())
//                        .font(Font.title)
//                    Text(asset.symbol)
//                        .font(Font.title)
//                }
//            }
//        }
//    }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
