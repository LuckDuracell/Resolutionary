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
        resolutions.remove(at: index)
        completed.remove(at: index)
        UserDefaults.standard.set(resolutions, forKey: "resolutions")
        UserDefaults.standard.set(completed, forKey: "completed")
    }
    
    var body: some View {
        VStack {
            GroupBox("Your Goals:", content: {
                List(resolutions.indices, id: \.self, rowContent: { index in
                    Goal(resolutions: $resolutions, completed: $completed, index: index)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                deleteRes(index)
                            } label: {
                                Text("Delete")
                            } .tint(.red)
                        }
                })
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
                    } .padding(5)
                }
            })
        }
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList(resolutions: .constant(["Reach 5,000 App Downloads", "Run a Sub-5 Minute Mile", "Do 5 Nice Things for People"]), completed: .constant(["0", "0", "0"]))
    }
}
