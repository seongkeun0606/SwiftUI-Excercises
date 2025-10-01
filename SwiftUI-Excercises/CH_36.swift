import SwiftUI

struct CH_36: View {

    var body: some View {
        TabView {
            VGridView()
                .tabItem {
                    Text("VGrid")
                }
            HGridView()
                .tabItem {
                    Text("HGrid")
                }
        }


    }
}

struct VGridView: View {
    private var colors: [Color] = [.blue, .yellow, .green]
    private var gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private var adaptiveGridItems = [GridItem(.adaptive(minimum: 50))]
    private var fixedGridItems = [GridItem(.fixed(100)), GridItem(.fixed(50)), GridItem(.fixed(75)), GridItem()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: fixedGridItems, spacing: 5) {
                ForEach(0...99, id: \.self) { index in
                    CellContentView(index: index, color: colors[index % colors.count])
                }
            }
            .padding(15)
        }
    }
}
struct HGridView: View {
    private var colors: [Color] = [.blue, .yellow, .green]
    private var gridItems = [GridItem(.adaptive(minimum: 50))]
    private var mixedGridItems = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 50)), GridItem(.fixed(150))]
    private var flexibleGridItems = [GridItem(.fixed(150)), GridItem(.flexible(minimum: 50)), GridItem(.fixed(150))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: flexibleGridItems, spacing: 5) {
                ForEach(0...99, id: \.self) { index in
                    CellContent(index: index, color: colors[index % colors.count])
                }
            }
        }
        .padding(.vertical, 10)
    }
}

struct CellContent: View {
    var index: Int
    var color: Color
    
    var body: some View {
        Text("\(index)")
            .frame(minWidth: 75, minHeight: 50, maxHeight: .infinity)
            .background(color)
            .cornerRadius(8)
            .font(.system(.largeTitle))
    }
}

struct CellContentView: View {
    var index: Int
    var color: Color
    
    var body: some View {
        Text("\(index)")
            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 100)
            .background(color)
            .cornerRadius(8)
            .font(.system(.largeTitle))
    }
}

#Preview {
    CH_36()
}
