//
//  TimerView.swift
//  Focus
//
//  Created by Amy Li on 9/17/23.
//

import Foundation //?

import SwiftUI

struct TimerView: View {
    @State private var minutesInput = ""
    @State private var isCountingDown = false
    @State private var remainingTime = 0
    @State private var timer: Timer?
    
    
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    

    var body: some View {
        VStack {
            Text("Focus in session.")
                .font(.title)
            
            Picker("Hours", selection: $selectedHours) {
                ForEach(0..<24, id: \.self) { hour in
                    Text("\(hour) hours")
                }
            }
            .pickerStyle(WheelPickerStyle())

            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute) minutes")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Button(action: startCountdown) {
                Text("Start timer")
//                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isCountingDown)
            
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Circle()
                    .trim(from: 0, to: CGFloat(remainingTime) / CGFloat(getTotalSeconds()))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                
                Text("\(formatTime(remainingTime))")
                    .font(.largeTitle)
            }
            .frame(width: 150, height: 150)
            .padding()
        }
        .padding()
    }

    func startCountdown() {
        
        let totalSeconds = selectedHours * 60 * 60 + selectedMinutes * 60
        remainingTime = totalSeconds
        isCountingDown = true
        
        withAnimation(.easeInOut) {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    stopCountdown()
                }
            }
        }
    }

    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        isCountingDown = false
    }

    func getTotalSeconds() -> Double {
        return (Double(selectedHours * 60 * 60 + selectedMinutes * 60))
    }

    func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }
}

