//
//  AssistantLink.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/13/22.
//

import SwiftUI

struct AssistantLink: View {
    
    @Binding var resolutions: [String]
    
    var body: some View {
        NavigationLink(destination: {
            Assistant(resolutions: $resolutions)
        }, label: {
            HStack {
                Image("OpenAI")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color.accentColor)
                Text("Resolution Assistant")
                Spacer()
                Image(systemName: "chevron.right")
            } .padding()
                .background(.regularMaterial)
                .cornerRadius(15)
        }) .padding()
    }
}

struct AssistantLink_Previews: PreviewProvider {
    static var previews: some View {
        AssistantLink(resolutions: .constant(["Reach 5,000 App Downloads", "Run a Sub-5 Minute Mile", "Do 5 Nice Things for People"]))
    }
}
