//
//  Main.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/11/22.
//

import SwiftUI

struct Main: View {
    
    @State var resolutions: [String] = UserDefaults.standard.stringArray(forKey: "resolutions") ?? []
    @State var completed: [String] = UserDefaults.standard.stringArray(forKey: "completed") ?? []
    @State var name = UserDefaults.standard.string(forKey: "userName") ?? ""
    
    @State var showSheet = false
    
    let inspirationals = ["remember why you made those resolutions in the first place, you got this!", "make sure to show today whos boss, and get to working on those resolutions!", "every day is a story, make today's into one about completing new years resolutions!", "lets get those resolutions done! Completing your resolutions this year is going to feel great, and I know you can get there!"]
    
    @State var testing = ["Testing 1", "Testing 2", "Testing 3", "Testing 4"]
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var selectedInspirational = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ProgressBar()
                    GoalList(resolutions: $resolutions, completed: $completed)
                    AssistantLink(resolutions: $resolutions)
                    Text("Hey \(name), " + selectedInspirational)
                        .padding()
                        .multilineTextAlignment(.center)
                } .navigationTitle("Your Resolutions")
                    .onAppear(perform: {
                        selectedInspirational = inspirationals.randomElement()!
                        UITextView.appearance().backgroundColor = .clear
                        if name == "" {
                            showSheet = true
                        }
                    })
                    .sheet(isPresented: $showSheet, content: {
                        Onboarding(showSheet: $showSheet)
                    })
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
