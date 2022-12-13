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
    
    func deleteRes(_ index: Int) {
        resolutions.remove(at: index)
        completed.remove(at: index)
        UserDefaults.standard.set(resolutions, forKey: "resolutions")
        UserDefaults.standard.set(completed, forKey: "completed")
    }
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ProgressBar()
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.top)
                    GroupBox("Your Goals:", content: {
                        List(selection: resolutions.indices, content: { index in
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
                                .edgesIgnoringSafeArea(.all)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        deleteRes(index)
                                    } label: {
                                        Text("Delete")
                                    } .tint(.red)
                                }
                            }
                        }) .edgesIgnoringSafeArea(.all)
                    })
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    completed.append("0")
                                    resolutions.append("")
                                    UserDefaults.standard.set(resolutions, forKey: "resolutions")
                                    UserDefaults.standard.set(completed, forKey: "completed")
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.white, Color.accentColor)
                                    .font(.title)
                            } .padding(5)
                            Spacer()
                        }
                    }
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
                    
                    Text("Hey \(name), " + selectedInspirational)
                        .padding()
                        .multilineTextAlignment(.center)
                } .navigationTitle("Your Resolutions")
            }
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

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
