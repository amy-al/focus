//
//  ContentView.swift
//  Focus
//
//  Created by Amy Li on 9/3/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView{
            VStack(spacing:20) {
                Text("Welcome to Focus!")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(height: 1.0)
                Text("Let's get to work.")
                    .font(.subheadline)
                NavigationLink(destination: TimerView()) {
                                    FocusButton(title: "Get started", textColor: .white, backgroundColor: .blue, w: 120, h: 30)
                    }
            }
            .navigationBarTitle("", displayMode: .inline) // no need for default navigation bar title display
            .navigationBarHidden(true)
        }
    }
}



// View for starting a timer for focus session
struct TimerView: View {
    @State private var isSessionRunning = false
    
    var body: some View {
        NavigationView{
            VStack(spacing:20) {
                Text("Start a session.")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(height: 1.0)
                    .padding(.vertical, 5)
                NavigationLink(destination: FocusView(), isActive: $isSessionRunning) {
                                    FocusButton(title: "Focus!", textColor: .white, backgroundColor: .red, w: 80, h: 30)
                                }
                }
                .navigationBarTitle("", displayMode: .inline) // no need for default navigation bar title display
                .navigationBarHidden(true)
            }
            .navigationBarBackButtonHidden(true)
    }
}

struct FocusView: View {
    var body: some View{
        Text("In focus.")
//        .navigationBarBackButtonHidden(true) // add end session early button if activate this
    }
    
}


// preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
