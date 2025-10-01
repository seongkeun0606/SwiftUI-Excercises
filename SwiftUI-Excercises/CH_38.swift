import SwiftUI

struct CH_38: View {
    @State private var selection = 1;
    var body: some View {
        TabView(selection: $selection) {
            FirstTabView1(selection: $selection)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Screen One")
                }
                .tag(1)
            Text("Second")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Screen Two")
                }
                .tag(2)
            Text("Thrid")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Screen Three")
                }
                .tag(3)
        }
        .font(.largeTitle)
    }
}

struct FirstTabView1: View {
    @Binding var selection: Int
    
    var body: some View {
        Button {
            selection = 3
        } label: {
            Text("Go to Third Tab")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    CH_38()
}
