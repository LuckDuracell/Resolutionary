//
//  Onboarding.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/11/22.
//

import SwiftUI

struct Onboarding: View {
    
    @State var name: String = ""
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            Text("Its time for some \nNew Years Resolutions!")
                .padding(30)
                .font(.title.bold())
                .multilineTextAlignment(.center)
            Text("We just need your name, to give you words of encouragement during your Resolutionary journey!")
                .padding(30)
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
            TextField("First Name", text: $name)
                .onChange(of: name, perform: { _ in
                    UserDefaults.standard.set(name, forKey: "userName")
                })
                .padding()
                .background(.regularMaterial)
                .cornerRadius(15)
                .padding()
            Spacer()
            Button {
                showSheet = false
            } label: {
                Text("Begin")
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding()
            }
            Spacer()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(showSheet: .constant(true))
    }
}
