//
//  CustomSecureField.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI

struct CustomSecureField: View {
    
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
            SecureField("", text: $text)
                .foregroundColor(Color(textFieldColor))
                .padding(.leading, padding)
        }
        .frame(width: frameWidht, height: frameHeight)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color(borderColor), lineWidth: lineWidth)
        }
    }
}
