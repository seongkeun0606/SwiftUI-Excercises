import SwiftUI

struct CH_29: View {
    @State private var stackPath = NavigationPath()
    @State private var toggleStatus = true
    @State private var listData: [ToDoItem] = [
        ToDoItem(task: "Buy groceries", imageName: "cart"),
        ToDoItem(task: "Walk the dog", imageName: "pawprint"),
        ToDoItem(task: "Read a book", imageName: "book")
    ]
    
    // MARK: - Functions
    func deleteItem(at offsets: IndexSet) {
        listData.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        listData.move(fromOffsets: source, toOffset: destination)
    }
    
    func addTask() {
        listData.append(ToDoItem(task: "New Task", imageName: "plus"))
    }

    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                // Settings Section
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow")
                    }
                }
                
                // To Do Tasks Section
                Section(header: Text("To Do Tasks")) {
                    ForEach(listData) { item in
                        NavigationLink(value: item) {
                            HStack {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .refreshable {
                listData = [
                    ToDoItem(task: "Exercise for 30 mins", imageName: "figure.walk"),
                    ToDoItem(task: "Call mom", imageName: "phone"),
                    ToDoItem(task: "Write journal", imageName: "pencil"),
                ]
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: addTask) { Text("Add") }
                    EditButton()
                }
            }
            // Value 기반 Navigation
            .navigationDestination(for: ToDoItem.self) { item in
                VStack(spacing: 20) {
                    Image(systemName: item.imageName)
                        .font(.largeTitle)
                    Text(item.task)
                        .font(.title)
                    Spacer()
                }
                .padding()
                .navigationTitle("Task Detail")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CH_29()
}

// MARK: - Model
struct ToDoItem: Identifiable, Hashable {
    var id = UUID()
    var task: String
    var imageName: String
}
