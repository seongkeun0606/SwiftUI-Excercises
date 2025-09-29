//
//  CH_26.swift
//  BookPractice
//
//  Created by 오성근 on 9/28/25.
//

import SwiftUI

struct CH_23: View {
    var colors: [Color] = [.red,.green,.blue,.purple];
    @State private var colorIndex = 0
    
    var body: some View {
        VStack {
            Text("Hello")
                .foregroundColor(colors[colorIndex])
        
        }
        .padding()
        
        Picker(selection: $colorIndex, label: Text("Color")) {
            ForEach (0..<colors.count, id: \.self) { color in
                Text("\(colors[color])").foregroundColor(colors[color])
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    CH_23()
}
