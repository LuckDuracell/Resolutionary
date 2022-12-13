//
//  Goal.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/13/22.
//

import SwiftUI

struct Goal: View {
    
    @Binding var resolutions: [String]
    @Binding var completed: [String]
    let index: Int
    
    var body: some View {
        HStack {
            TextField("Goal \(index + 1)", text: $resolutions[index])
                .onChange(of: resolutions[index], perform: { _ in
                    UserDefaults.standard.set(resolutions, forKey: "resolutions")
                })
            Button {
                if completed[index] == "1" { completed[index] = "0" } else { completed[index] = "1" }
            } label: {
                Image(systemName: completed[index] == "1" ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.accentColor)
            }
            .onChange(of: completed[index], perform: { _ in
                UserDefaults.standard.set(completed, forKey: "completed")
            })
        }
    }
}

struct Goal_Previews: PreviewProvider {
    static var previews: some View {
        Goal(resolutions: .constant(["Reach 5,000 App Downloads", "Run a Sub-5 Minute Mile", "Do 5 Nice Things for People"]), completed: .constant(["0", "0", "0"]), index: 0)
    }
}
