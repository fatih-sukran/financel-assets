import SwiftUI

struct CurrencyFormView: View {
    @State var id: UUID?
    @State var name: String
    @State var symbol: String
    
    private var formName: String = ""
    @ObservedObject private var dataManager = Database.shared.currencies
    @Environment(\.presentationMode) private var presentationMode
    
    init(uuid: UUID? = nil, name: String = "", symbol: String = "") {
        self._id = State(initialValue: uuid)
        self._name = State(initialValue: name)
        self._symbol = State(initialValue: symbol)
        formName = name.isEmpty ? "Add" : "Update"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Currency Name", text: $name)
                    TextField("Currency Symbol", text: $symbol)
                }

                Section {
                    Button("\(formName) Currency") {
                        onSave()
                    }
                    .disabled(name.isEmpty || symbol.isEmpty)
                }
            }
            .navigationBarTitle("\(formName) Currency")
        }
    }
    
    private func onSave() {
        var currency: Currency
        
        if id == nil {
            currency = Currency(name: name, symbol: symbol)
            dataManager.add(currency)
        } else {
            currency = Currency(id: id!, name: name, symbol: symbol)
            dataManager.update(currency)
        }
        
        name = ""
        symbol = ""
        presentationMode.wrappedValue.dismiss()
    }
}

struct ViewCurriencies: View {
    
    @ObservedObject private var dataManager = Database.shared.currencies
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataManager.items) { currency in
                    NavigationLink(destination: CurrencyFormView(uuid: currency.id, name: currency.name, symbol: currency.symbol)) {
                        Text(currency.name)
                        Text(currency.symbol)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: dataManager.delete)
            }
            .navigationBarTitle("Currency")
            .navigationBarItems(trailing: NavigationLink(destination: CurrencyFormView()) {
                Image(systemName: "plus")
            })
        }
    }
    
    
}
