import SwiftUI

struct CurrencyFormView: View {
    @State var id: UUID?
    @State var name: String
    @State var symbol: String
    
    private var formName: String = ""
    @ObservedObject var viewModel: CurrencyViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    init(uuid: UUID? = nil, name: String = "", symbol: String = "", viewModel: CurrencyViewModel) {
        self._id = State(initialValue: uuid)
        self._name = State(initialValue: name)
        self._symbol = State(initialValue: symbol)
        self.viewModel = viewModel
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
            viewModel.add(currency)
        } else {
            currency = Currency(id: id!, name: name, symbol: symbol)
            viewModel.update(currency)
        }
        
        name = ""
        symbol = ""
        presentationMode.wrappedValue.dismiss()
    }
}

struct ViewCurriencies: View {
    @ObservedObject var viewModel: CurrencyViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { currency in
                    NavigationLink(destination: CurrencyFormView(uuid: currency.id, name: currency.name, symbol: currency.symbol, viewModel: viewModel)) {
                        Text(currency.name)
                        Text(currency.symbol)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationBarTitle("Currency")
            .navigationBarItems(trailing: NavigationLink(destination: CurrencyFormView(viewModel: viewModel)) {
                Image(systemName: "plus")
            })
        }
    }
}
