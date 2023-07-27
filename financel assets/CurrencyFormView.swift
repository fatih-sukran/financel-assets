import SwiftUI

struct CurrencyFormView: View {
    @StateObject private var db = Database()

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(db.currencies) { currency in
                        Text(currency.name)
                    }
                }
            }
            .navigationTitle("Currency Form")
        }
    }
}

struct AddCurrencyFormView: View {
    @StateObject private var db = Database()
    
    @State private var name: String = ""
    @State private var symbol: String = ""
    
    
    var body: some View {
        Form {
            Section {
                TextField("Currency Name", text: $name)
                TextField("Currency Symbol", text: $symbol)
            }
            
            Section {
                Button("Add") {
                    let currency = Currency(name: name, symbol: symbol)
                    db.currencies.append(currency)
                    db.save()
                    
                    name = ""
                    symbol = ""
                }
            }
        }
    }
}



struct CurrencyFormView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CurrencyFormView()
            AddCurrencyFormView()
        }
    }
}
