import SwiftUI

struct CH_37: View {
    var body: some View {
        ScrollView {
            Grid(horizontalSpacing: 5, verticalSpacing: 10) {
                GridRow {
                    GridCellContent(index: 0, color: .orange)
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    GridCellContent(index: 0, color: .orange)
                }
                .font(.largeTitle)
                GridRow {
                    GridCellContent(index: 0, color: .orange)
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    GridCellContent(index: 0, color: .orange)
                }
                .font(.largeTitle)
                GridRow {
                    GridCellContent(index: 0, color: .orange)
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    Image(systemName: "record.circle.fill")
                    GridCellContent(index: 0, color: .orange)
                }
                .font(.largeTitle)
                
                GridRow {
                    ForEach(1...5, id: \.self) { index in
                        GridCellContent(index: index, color: .red)
                    }
                }
                GridRow {
                    ForEach(6...10, id: \.self) { index in
                        GridCellContent(index: index, color: .blue)
                    }
                }
                GridRow {
                    ForEach(11...15, id: \.self) { index in
                        GridCellContent(index: index, color: .green)
                    }
                }
                
                GridCellContent(index: 16, color: .blue)
                
                GridRow {
                    GridCellContent(index: 17, color: .orange)
                        .gridCellColumns(2)
                    GridCellContent(index: 18, color: .indigo)
                        .gridCellColumns(3)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    CH_37()
}

struct GridCellContent: View {
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
