import SwiftUI
import Foundation
import Combine

struct CH_27: View {
    @StateObject var timerData = TimerData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Timer count = \(timerData.timerCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Button("reset") {
                    timerData.resetCount()
                }
                
                NavigationLink(destination: SecondView()
                                .environmentObject(timerData)) { // 부모에서 주입
                    Text("Next screen")
                }
                .padding()
            }
        }
    }
}


struct SecondView: View {
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        VStack {
            Text("Second")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timerCount)")
                .font(.headline)
        }
        .padding()
    }
}


#Preview {
    CH_27()
}


class TimerData: ObservableObject {
    @Published var timerCount = 0
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire() {
        timerCount += 1
    }
    
    func resetCount() {
        timerCount = 0
    }
}
