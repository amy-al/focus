//
//  ContentView.swift
//  Focus
//
//  Created by Amy Li on 9/3/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var isSessionRunning = false
    
    var body: some View {
        
        VStack(spacing:20) {
            Text("Welcome to Focus!")
                .font(.title)
                .fontWeight(.bold)
                .frame(height: 1.0)
            Text("Let's get to work.")
                .font(.subheadline)
            Button{
                isSessionRunning.toggle()
            } label:{
                FocusButton(title: "Start a focus session", textColor: .white, backgroundColor: .blue, w: 120, h: 30)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
