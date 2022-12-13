//
//  Buttons.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/11/22.
//

import Foundation
import SwiftUI

struct FlyButton: View {
    
    let icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.width * 0.06)
            Image(systemName: icon)
                .resizable()
                .foregroundColor(Color.accentColor)
                .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07)
        }
    }
}

struct SpinButton: View {
    
    let icon: String
    @Binding var rotating: Bool
    @State var deg: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.width * 0.06)
            Image(systemName: icon)
                .resizable()
                .foregroundColor(Color.accentColor)
                .rotationEffect(Angle(degrees: deg))
                .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07)
                .onChange(of: rotating, perform: { _ in
                    if rotating == true {
                        withAnimation {
                            deg = -360
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            deg = 0
                            rotating = false
                        })
                    }
                })
        }
    }
}
