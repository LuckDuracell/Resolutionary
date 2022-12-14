//
//  GoalList.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/13/22.
//

import SwiftUI

struct GoalList: View {
    
    @Binding var resolutions: [String]
    @Binding var completed: [String]
    
    func deleteRes(_ index: Int) {
        withAnimation {
            resolutions.remove(at: index)
            completed.remove(at: index)
        }
        UserDefaults.standard.set(resolutions, forKey: "resolutions")
        UserDefaults.standard.set(completed, forKey: "completed")
    }
    
    let screenWidth = UIScreen.main.bounds.width
    
    @State var rowHeight: CGFloat = 45
    
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Goals:")
                    .bold()
                    .padding(.leading, 5)
                Spacer()
            }
            List(resolutions.indices, id: \.self, rowContent: { index in
                GeometryReader { (geometry) in
                    HStack {
                        TextField("Goal \(index + 1)", text: $resolutions[index])
                            .onChange(of: resolutions[index], perform: { _ in
                                UserDefaults.standard.set(resolutions, forKey: "resolutions")
                            })
                            .focused($focused)
                            .frame(width: screenWidth * 0.7)
                        Spacer()
                        Button {
                            if completed[index] == "1" { completed[index] = "0" } else { completed[index] = "1" }
                        } label: {
                            Image(systemName: completed[index] == "1" ? "largecircle.fill.circle" : "circle")
                                .foregroundColor(.accentColor)
                        }
                        .onChange(of: completed[index], perform: { _ in
                            UserDefaults.standard.set(completed, forKey: "completed")
                        })
                    } .padding(.top, 6)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            deleteRes(index)
                        } label: {
                            Text("Delete")
                        } .tint(.red)
                    }
                    .onAppear(perform: {
                        withAnimation {
                            rowHeight = geometry.size.height
                        }
                    })
                }
            })
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(width: screenWidth * 0.95, height: rowHeight * CGFloat(resolutions.count) + 75, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, -100)
            .padding(.top, -30)
            Divider()
            HStack(alignment: .center) {
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
                } .padding(3)
            }
        } .padding()
            .background(.regularMaterial)
            .cornerRadius(15)
            .padding()
            .toolbar(content: { ToolbarItem(placement: .keyboard, content: {
                Button {
                    focused.toggle()
                } label: {
                    Text("Done")
                } .frame(width: screenWidth * 0.9, alignment: .trailing)
                })
            })
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList(resolutions: .constant(["Reach 5,000 App Downloads", "Run a Sub-5 Minute Mile", "Do 5 Nice Things for People"]), completed: .constant(["0", "0", "0"]))
    }
}
