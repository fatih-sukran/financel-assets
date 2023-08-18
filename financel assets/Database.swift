import Foundation


typealias Model = Identifiable & Codable & Hashable

class IDataManager<Item: Model> : ObservableObject {

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
    
    func getById(_ id: UUID) -> Item? {
        return items.first(where: {$0.id as! UUID == id})
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
