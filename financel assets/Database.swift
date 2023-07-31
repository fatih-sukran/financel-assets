import Foundation
import CoreData

class IDataManager<Item: Codable & Equatable & Identifiable> : ObservableObject {

    @Published var items : [Item] = []
    
    init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "\(Item.self)") {
            print("Item.self: \(Item.self)")
            if let decodedData = try? JSONDecoder().decode([Item].self, from: data) {
                items = decodedData
                return
            }
        }
    }
    
    func add(_ item: Item) {
        items.append(item)
        self.save()
    }
    
    func delete(_ indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        self.save()
    }
    
    func delete(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            self.save()
        }
    }
    
    func update(_ item: Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item
            self.save()
        }
    }
    
    func getAll() -> [Item] {
        return items
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "\(Item.self)")
        }
    }
    
}

struct Currency: Identifiable, Codable, Equatable {
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
    static let shared = Database()
    
    @Published var currencies = IDataManager<Currency>()
    @Published var datas = IDataManager<Currency>()
    @Published var prices = IDataManager<Currency>()
}
