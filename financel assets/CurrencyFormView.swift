import SwiftUI

class TodoItem: Identifiable, ObservableObject {
    let id = UUID()
    @Published var title: String

    init(title: String) {
        self.title = title
    }
}

struct CurrencyFormView: View {
    @ObservedObject var viewModel: CurrencyFormViewModel

    var body: some View {
        VStack {
            EditableList(data: $viewModel.items) { item in
                TextField("Name: ", text: item.title) // Use $ to pass the binding
            }
        }
    }
}

class CurrencyFormViewModel: ObservableObject {
    @Published var items: [TodoItem] = []

    init(items: [TodoItem]) {
        self.items = items
    }
}

struct EditableList<Data: RandomAccessCollection & MutableCollection, Content: View>: View where Data.Element: Identifiable {
    @Binding var data: Data
    var content: (Binding<Data.Element>) -> Content

    init(data: Binding<Data>, content: @escaping (Binding<Data.Element>) -> Content) {
        self._data = data
        self.content = content
    }

    var body: some View {
        List {
            ForEach($data) { item in // Use $ to pass the binding
                content(item) // Use $ to pass the binding
            }
            .onMove { indexSet, offset in
                data.move(fromOffsets: indexSet, toOffset: offset)
            }
            .onDelete { indexSet in
//                $data.remove(atOffsets: indexSet)
            }
        }
        .toolbar { EditButton() }
    }
}

struct CurrencyFormView_Previews: PreviewProvider {
    static var previews: some View {
        var items = [
            TodoItem(title: "abc"),
            TodoItem(title: "def"),
            TodoItem(title: "ghi")
        ]
        CurrencyFormView(viewModel: CurrencyFormViewModel(items: items))
    }
}
