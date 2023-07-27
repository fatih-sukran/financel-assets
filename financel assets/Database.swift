import Foundation

struct Currency: Identifiable, Codable {
    var id = UUID()
    var name: String
    var symbol: String
}

struct DataEntry: Identifiable, Codable {
    var id = UUID()
    var currencyId: UUID
    var date: Date
    var amount: Double
}

struct Price: Identifiable, Codable {
    var id = UUID()
    var currencyId: UUID
    var date: Date
    var price: Double
}

class DataManager {
    private let currencyKeyName = "Currency"
    private let dataKeyName = "Data"
    private let priceKeyName = "Price"

    func save(currencies: [Currency], datas: [DataEntry], prices: [Price]) {
        if let encoded = try? JSONEncoder().encode(currencies) {
            UserDefaults.standard.set(encoded, forKey: currencyKeyName)
        }
        
        if let encoded = try? JSONEncoder().encode(datas) {
            UserDefaults.standard.set(encoded, forKey: dataKeyName)
        }
        
        if let encoded = try? JSONEncoder().encode(prices) {
            UserDefaults.standard.set(encoded, forKey: priceKeyName)
        }
        
    }

    func load() -> ([Currency], [DataEntry], [Price]) {
        var currencies: [Currency] = []
        var datas: [DataEntry] = []
        var prices: [Price] = []
        
        if let currencyData = UserDefaults.standard.data(forKey: currencyKeyName),
           let decodedCurrencies = try? JSONDecoder().decode([Currency].self, from: currencyData) {
            currencies = decodedCurrencies
        }
        
        if let dataData = UserDefaults.standard.data(forKey: dataKeyName),
           let decodedDatas = try? JSONDecoder().decode([DataEntry].self, from: dataData) {
            datas = decodedDatas
        }
        
        if let priceData = UserDefaults.standard.data(forKey: priceKeyName),
           let decodedPrices = try? JSONDecoder().decode([Price].self, from: priceData) {
            prices = decodedPrices
        }
        
        return (currencies, datas, prices)
    }
}

@MainActor
class Database: ObservableObject {
    @Published var currencies: [Currency]
    @Published var datas: [DataEntry]
    @Published var prices: [Price]
    
    init() {
        let dataManager = DataManager()
        (currencies, datas, prices) = dataManager.load()
    }
    
    func save() {
        let dataManager = DataManager()
        dataManager.save(currencies: currencies, datas: datas, prices: prices)
    }
}
