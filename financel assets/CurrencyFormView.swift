import SwiftUI

struct CurrencyFormView: View {
    @StateObject private var db = Database()
    @State private var showAddView = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(0..<db.currencies.count) { i in
                        Text(db.currencies[i].name)
                            .swipeActions(allowsFullSwipe: false) {
                            
                                Button(role: .destructive, action: {
                                    db.currencies.remove(at: i)
                                    db.save()
                                }, label: {
                                Label("Add Currency", systemImage: "trash")
                            })
    //                        .tint(.accentColor)
                            Button(action: {
                                showAddView.toggle()
                            }, label: {
                                Label("Add Currency", systemImage: "pencil")
                                    .bold()
                            })
                            .tint(.accentColor)
                        }
                    }
//                    .onDelete(perform: delete)
                    
                }
            }
            .navigationTitle("Currency Form")
            .toolbar {
                Button(action: {
                    showAddView.toggle()
                }, label: {
                    Label("Add Currency", systemImage: "plus")
                })
            }
            .sheet(isPresented: $showAddView) {
                AddCurrencyFormView(db: db)
                    .presentationDetents([.medium])
            }
        }
    }
}

struct AddCurrencyFormView: View {
    @StateObject var db: Database
    
    @State private var name: String = ""
    @State private var symbol: String = ""
    
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Add New Currency")
        }
    }
}



struct CurrencyFormView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CurrencyFormView()
        }
    }
}
