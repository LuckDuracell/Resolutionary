//
//  ProgressBar.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/11/22.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var prog: Double = 0
    
    
    var body: some View {
        VStack {
            HStack {
                Text(1 - ((prog / 365) * 10000).rounded() / 10000, format: .percent)
                    .padding(.trailing, -3)
                Text("Left of \(Date().formatted(Date.FormatStyle().year()))")
                Spacer()
            }
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * (prog / 365) * 0.8, height: 40)
                    .foregroundColor(.accentColor)
            } .onAppear(perform: {
                withAnimation {
                    prog = Double(Date().formatted(Date.FormatStyle().dayOfYear()))!
                }
            })
            .cornerRadius(15)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
