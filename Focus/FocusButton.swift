//
//  FocusButton.swift
//  Focus
//
//  Created by Amy Li on 9/3/23.
//

import SwiftUI

// reusable button
struct FocusButton: View {
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var w: CGFloat
    var h: CGFloat
    
    var body: some View{
        Text(title)
        .frame(width: w, height: h)
        .background(backgroundColor)
        .foregroundColor(textColor)
        .font(.system(size: 16, weight: .bold, design: .default))
        .cornerRadius(15)
    }
    
}
