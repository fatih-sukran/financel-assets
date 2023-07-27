import Foundation

struct Currency: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: Double
    var amount: Double
    var symbol: String
}

struct AssetData: Identifiable, Codable {
    var id = UUID()
    var tl: Currency
    var dolar: Currency
    var altin: Currency
    var bitcoin: Currency
    var etherium: Currency
    var bist100: Currency
    var other: Currency
}

class DataManager {
    private let keyName = "Currencies"

    func save(data: [AssetData]) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: keyName)
        }
    }

    func load() -> [AssetData] {
        if let data = UserDefaults.standard.data(forKey: keyName),
           let decodedData = try? JSONDecoder().decode([AssetData].self, from: data) {
            return decodedData
        }
        return []
    }
}

@MainActor
class Database: ObservableObject {
    
    @Published var datas: [AssetData]
    
    init() {
        let dataManager = DataManager()
        datas = dataManager.load()
    }
    
    func save() {
        let dataManager = DataManager()
        dataManager.save(data: datas)
    }
}
