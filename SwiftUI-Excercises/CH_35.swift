
import SwiftUI

struct CH_35: View {
    var body: some View {
        TabView {
            OutlineGroupTapView()
                .tabItem {
                    Text("Outline")
                }
            DisclosureGroupTabView()
                .tabItem {
                    Text("Disclosure")
                }
        }
    }
}

struct DisclosureGroupTabView: View {
    @State private var hybridState = false
    @State private var electricState = false
    @State private var fuelCellState = false
    @State private var inversionState = false
    @State private var filteresExpanded: Bool = true

    var body: some View {
        Form {
            DisclosureGroup(isExpanded: $filteresExpanded) {
                ToggleControl(title: " Hybrid Cars", state: hybridState)
                ToggleControl(title: " Electric Cars", state: electricState)
                ToggleControl(title: " Fuel Cell Cars", state: fuelCellState)
            } label: {
                Label("Categories Filters", systemImage: "car.2.fill")
            }
            
            DisclosureGroup {
                ColorControl(color: .red, label: "Background Color")
                ColorControl(color: .blue, label: "ForegroundColor")
                ToggleControl(title: "Color Inversion", state: inversionState)
            } label: {
                Label("Color Settings", systemImage: "scribble.variable")
            }
            
        }
    }
}

struct ColorControl: View {
    var color: Color
    var label: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Rectangle()
                .fill(color)
                .frame(width: 30, height: 30)
        }
        .padding(.leading)
        .scaledToFill()
    }
}

struct ToggleControl: View {
    var title: String
    @State var state: Bool
    
    var body: some View {
        Toggle(title, isOn: $state)
            .padding(.leading)
    }
}

struct OutlineGroupTapView: View {
    var body: some View {
        List {
            ForEach(carItems) { carItem in
                Section(header: Text(carItem.name)) {
                    OutlineGroup(carItem.children ?? [CarInfo](),
                                 children: \.children) { child in
                        CellView(item: child)
                    }
                }
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct CellView: View {
    var item: CarInfo
    
    var body: some View {
        HStack {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.green)
            Text(item.image)
        }
    }
}

#Preview {
    CH_35()
}

struct CarInfo: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var children: [CarInfo]?
}

let carItems: [CarInfo] = [
    
    CarInfo(name: "Hybrid Cars", image: "leaf.fill", children: [
        CarInfo(name: "Toyota", image: "car.circle", children : [
            CarInfo(name: "Prius", image: "leaf.fill"),
            CarInfo(name: "Highlander Hybrid", image: "leaf.fill"),
            CarInfo(name: "Lexus", image: "car.circle", children: [
                    CarInfo(name: "Lexus RX", image: "leaf.fill"),
                    CarInfo(name: "Lexus NX", image: "leaf.fill")])
        ]),
        CarInfo(name: "Ford", image: "car.circle", children : [
            CarInfo(name: "Fusion Energi", image: "leaf.fill"),
            CarInfo(name: "Escape", image: "leaf.fill"),
            CarInfo(name: "Volvo", image: "car.circle", children: [
                    CarInfo(name: "S90 Hybrid", image: "leaf.fill"),
                    CarInfo(name: "XC90 Hybrid", image: "leaf.fill")])
        ]),
    ]),
    
    CarInfo(name: "Electric Cars", image: "bolt.car.fill", children: [
        CarInfo(name: "Tesla", image: "car.circle", children : [
            CarInfo(name: "Model 3", image: "bolt.car.fill")
        ]),
        CarInfo(name: "Karma", image: "car.circle", children : [
            CarInfo(name: "Revero GT", image: "bolt.car.fill")
        ])
    ])
]

