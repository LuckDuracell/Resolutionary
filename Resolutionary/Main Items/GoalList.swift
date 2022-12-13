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
    
    let screenWidth = UIScreen.main.bounds.width * 0.95
    
    @State var rowHeight: CGFloat = 45
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Goals:")
                    .bold()
                    .padding(.leading, 5)
                Spacer()
            }
            //Divider()
            List(resolutions.indices, id: \.self, rowContent: { index in
                GeometryReader { (geometry) in
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
                        .padding(.top, 3)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            deleteRes(index)
                        } label: {
                            Text("Delete")
                        } .tint(.red)
                    }
                    .listRowBackground(Color.clear)
                    .onAppear(perform: {
                        withAnimation {
                            rowHeight = geometry.size.height
                        }
                    })
                }
            }) .scrollContentBackground(.hidden)
                .frame(width: screenWidth, height: rowHeight * CGFloat(resolutions.count) + 130, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .padding(.horizontal, -100)
                .padding(.vertical, -40)
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
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList(resolutions: .constant(["Reach 5,000 App Downloads", "Run a Sub-5 Minute Mile", "Do 5 Nice Things for People"]), completed: .constant(["0", "0", "0"]))
    }
}
