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

    var body: some View {
        VStack {
            Text("Focus in session.")
                .font(.title)
                .padding()
            
            TextField("Enter minutes", text: $minutesInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            Button(action: startCountdown) {
                Text("Start timer")
                    .font(.headline)
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
                    .animation(.easeInOut)
                
                Text("\(formatTime(remainingTime))")
                    .font(.largeTitle)
            }
            .frame(width: 150, height: 150)
            .padding()
        }
        .padding()
    }

    func startCountdown() {
        guard let minutes = Int(minutesInput), minutes > 0 else {
            return
        }
        
        let totalSeconds = minutes * 60
        remainingTime = totalSeconds
        isCountingDown = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopCountdown()
            }
        }
    }

    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        isCountingDown = false
    }

    func getTotalSeconds() -> Double {
        return Double(Int(minutesInput) ?? 0) * 60
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

