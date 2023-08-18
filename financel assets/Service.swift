//
//  Service.swift
//  financel assets
//
//  Created by Fatih Şükran on 16.08.2023.
//

import Foundation

class PriceViewModel2: ObservableObject {
    
    @Published var symbols: [String: [SymbolPrice]] = [:]
    private let decodeKey = "SymbolPrices"
    
    init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: decodeKey) {
            if let decodedData = try? JSONDecoder().decode([String: [SymbolPrice]].self, from: data) {
                symbols = decodedData
            }
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(symbols) {
            UserDefaults.standard.set(encoded, forKey: decodeKey)
        }
    }
    
    func getPrice(date: Date, symbol: String, base: String = "USD") async -> SymbolPrice {
        if symbols[symbol] == nil || !symbols[symbol]!.contains(where: {$0.dateTime == date}) {
            await fetch(symbol: symbol, base: base)
        }
        
        return symbols[symbol]!.first(where: {$0.dateTime == date})!
    }
    
    private func fetch(symbol: String = "BTC", base: String = "USD") async {
        let endPoint = "https://twelve-data1.p.rapidapi.com/time_series?symbol=\(symbol)%2F\(base)&interval=1day&outputsize=21&format=json"
        let headers = [
            "X-RapidAPI-Key": "be028357b9msh0054bec9c00787ep12c607jsn6a7dda874d5f",
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]
                
        guard let url = URL(string: endPoint) else {
            print("İnvalid url")
            return
        }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Attempt to convert the data into a JSON object
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            var symbols: [SymbolPrice] = []
            for case let priceItem in json?["values"] as! [[String : Any]] {
                if let symbol = SymbolPrice(json: priceItem){
                    symbols.append(symbol)
                }
            }
            add(symbol: symbol, items: symbols)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func add(symbol: String, item: SymbolPrice) {
       add(symbol: symbol, items: [item])
    }

    func add(symbol: String, items: [SymbolPrice]) {
        guard var symbolPrices = symbols[symbol] else {
            symbols[symbol] = items
            return
        }
        
        for item in items {
            if !symbolPrices.contains(where: { $0.dateTime == item.dateTime }) {
                symbolPrices.append(item)
            }
        }
        
        symbols[symbol] = symbolPrices
        save()
    }
}

enum ServiceError: Error {
    case invalidUrl
    
}

struct SymbolPrice: Model {
    var id = UUID()
    let dateTime: Date
    let close: String
    let open: String
    let high: String
    let low: String
    
    init?(json: [String: Any]) {
        guard let dateTime = json["datetime"] as? String,
              let close = json["close"] as? String,
              let open = json["open"] as? String,
              let high = json["high"] as? String,
              let low = json["low"] as? String else {
            return nil
        }
        
        let dateFormat = "yyyy-mm-dd"
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        self.dateTime = dateFormatter.date(from: dateTime)!
        self.close = close
        self.open = open
        self.high = high
        self.low = low
    }
}
