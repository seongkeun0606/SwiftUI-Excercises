import Combine
import SwiftUI
import UIKit

struct CH_31: View {
    @StateObject var carStore: CarStore = CarStore(cars: carData)
    @State private var stackPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                ForEach(0..<carStore.cars.count, id: \.self) { i in
                    NavigationLink(value: i) {
                        ListCell(car: carStore.cars[i])
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationDestination(for: Int.self) { i in
                CarDetail(selectedCar: carStore.cars[i])
            }
            .navigationDestination(for: String.self) { _ in
                AddNewCar(carStore: self.carStore, path: $stackPath)
            }
            .navigationTitle(Text("EV Cars"))
            .navigationBarItems(leading: NavigationLink(value: "Add Car") {
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        carStore.cars.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        let itemsToMove = source.map { carStore.cars[$0] }
        
        // 기존 위치 삭제 (역순으로)
        for index in source.sorted(by: >) {
            carStore.cars.remove(at: index)
        }
        
        // 새 위치에 삽입
        var insertIndex = destination
        for item in itemsToMove {
            carStore.cars.insert(item, at: insertIndex)
            insertIndex += 1
        }
    }
}

struct ListCell: View {
    var car: Car
    var body: some View {
        HStack {
            Image(car.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 60)
            Text(car.name)
        }
    }
}

struct CarDetail: View {
    let selectedCar: Car
    
    var body: some View {
        Form {
            Section(header: Text("Car Details")) {
                Image(selectedCar.imageName)
                    .resizable()
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(selectedCar.name)
                    .font(.headline)
                
                Text(selectedCar.description)
                    .font(.body)
                
                HStack {
                    Text("Hybrid").font(.headline)
                    Spacer()
                    Image(systemName: selectedCar.isHybrid ? "checkmark.circle" : "xmark.circle")
                }
            }
        }
    }
}

struct AddNewCar: View {
    @StateObject var carStore: CarStore
    @State private var isHybrid = false
    @State private var name = ""
    @State private var description = ""
    @Binding var path: NavigationPath
    
    var body: some View {
        Form {
            Section(header: Text("Car Details")) {
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                Toggle(isOn: $isHybrid) {
                    Text("Hybrid").font(.headline)
                }.padding()
            }
            
            Button(action: addNewCar) {
                Text("Add Car")
            }
        }
    }
    
    func addNewCar() {
        let newCar = Car(id: UUID().uuidString, name: name, description: description, isHybrid: isHybrid, imageName: "tesla_model_3")
        carStore.cars.append(newCar)
        path.removeLast()
    }
}

struct DataInput: View {
    var title: String
    @Binding var userInput: String

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

#Preview {
    CH_31()
}

var carData: [Car] = loadJson("carData.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("\(filename) not found")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename)")
    }
}

class CarStore: ObservableObject {
    @Published var cars: [Car]
    
    init (cars: [Car] = []) {
        self.cars = cars
    }
}

struct Car: Codable, Identifiable {
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool

    var imageName: String
}
