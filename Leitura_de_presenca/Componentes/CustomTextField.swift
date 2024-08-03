//
//  CustomTextField.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeholder: String
    var padding: Double
    @Binding var text: String
    var textColor : Color
    var textFieldColor : Color
    var borderColor : Color
    var frameWidht : Double
    var frameHeight : Double
    var cornerRadius : Double
    var lineWidth : Double
    var alignment : Alignment
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(textColor))
                    .padding(.horizontal, padding)
            }
            TextField("", text: $text)
                .foregroundColor(Color(textFieldColor))
                .padding(.horizontal, padding)
        }
        .frame(width: frameWidht, height: frameHeight, alignment: alignment)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color(borderColor), lineWidth: lineWidth)
        }
    }
}
