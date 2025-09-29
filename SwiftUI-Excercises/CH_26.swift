//
//  CH_25.swift
//  BookPractice
//
//  Created by 오성근 on 9/28/25.
//

import SwiftUI

func changeTitle(title: String) async -> String {
    sleep(5)
    if title == "View one" {
        return "Async task completed"
    } else {
        return "View one"
    }
}
struct FirstTabView: View {
    @State var title = "View one"
    
    var body: some View {
        Text(title)
            .onAppear(perform: {
                print("onAppear")
            })
            .onDisappear(perform: {
                print("onDisappeared")
            })
            .task(priority: .background) {
                title = await changeTitle(title: title)
            }
    }
}
struct SecondTabView: View {
    @State private var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .onChange(of: text, perform: { value in
                print("change triggerd \(value)")
            })
    }
}

struct CH_26: View {
    var body: some View {
        TabView {
            FirstTabView()
                .tabItem {
                    Text("First")
                }
            SecondTabView()
                .tabItem {
                    Text("Seoncd")
                        .font(.largeTitle)
                }
        }
    }
}

#Preview {
    CH_26()
}
