//
//  ChatArt.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/17/22.
//

import SwiftUI

struct ChatArt: View {
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            VStack {
                VStack(alignment: .center, spacing: 15) {
                    HStack {
                        Spacer()
                        Text("How can I succeed\nat my New Years Goal?")
                            .foregroundColor(.white)
                            .bold()
                            .padding(8)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    }
                    HStack {
                        VStack() {
                            HStack {
                                Text("Thats easy! Just...")
                                Spacer()
                            } .padding(.top, 2)
                                .padding(.leading, 3)
                            VStack(alignment: .trailing, spacing: -20) {
                                Text("•")
                                    .font(.title)
                                Text("•")
                                    .font(.title)
                                Text("•")
                                    .font(.title)
                            }
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: size.width * 0.35)
                        .padding(8)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ChatArt_Previews: PreviewProvider {
    static var previews: some View {
        ChatArt()
    }
}
