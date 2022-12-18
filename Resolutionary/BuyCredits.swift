//
//  BuyCredits.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/17/22.
//

import SwiftUI

struct BuyCredits: View {
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            
            VStack(alignment: .center, spacing: 15) {
                Text("Purchase Credits")
                    .font(.title.bold())
                    .padding(.top, 30)
                ChatArt()
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(25)
                    .padding()
                    .frame(height: size.height * 0.32)
                Button {
                    //$0.99
                } label: {
                    Text("10 Messages")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: size.width * 0.8, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.regularMaterial)
                                .padding(5)
                                .background(Color.accentColor)
                                .cornerRadius(25)
                        )
                }
                Button {
                    //$3.99
                } label: {
                    Text("50 Messages")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: size.width * 0.8, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.regularMaterial)
                                .padding(5)
                                .background(Color.accentColor)
                                .cornerRadius(25)
                        )
                }
                Button {
                    //$8.99
                } label: {
                    Text("125 Messages")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: size.width * 0.8, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.regularMaterial)
                                .padding(5)
                                .background(Color.accentColor)
                                .cornerRadius(25)
                        )
                }
                Spacer()
                Button {
                    //restore purchases
                } label: {
                    Text("Restore Purchases")
                        .foregroundColor(.gray)
                        .underline()
                }
            } .frame(width: size.width, alignment: .center)
        }
    }
}

struct BuyCredits_Previews: PreviewProvider {
    static var previews: some View {
        BuyCredits()
    }
}
