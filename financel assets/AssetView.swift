//
//  ContentView.swift
//  financel assets
//
//  Created by Fatih Şükran on 26.07.2023.
//

import SwiftUI

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangle(cornerSize: CGSize(width: 400, height: 200), style: .continuous)
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
        ).cornerRadius(21)

    }
}
