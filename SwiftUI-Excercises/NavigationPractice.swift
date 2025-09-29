import SwiftUI

struct NavigationPractice: View {
    var items: [String] = ["A", "B", "C", "D"]
    @State private var stackPath = NavigationPath()

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    Text(item)
                }
            }
            .navigationTitle("Items")
        }
        NavigationStack(path: $stackPath) {
            List(items, id: \.self) { item in
                NavigationLink(value: item) {
                    Text(item)
                }
            }
            .navigationDestination(for: String.self) { item in
                DetailView(item: item)
            }
            .navigationTitle("Items")
        }

    }
}

struct DetailView: View {
    var item: String
    
    var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

#Preview {
    NavigationPractice()
}
