//
//  CustomTextField.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeholder: String
    @Binding var text: String
    var textColor : UIColor
    var borderColor : UIColor
    var frameWidht : Double
    var frameHeight : Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(textColor))
                    .padding(.horizontal, 12)
            }
            TextField("", text: $text)
                .foregroundColor(Color(textColor))
                .padding(.horizontal, 12)
        }
        .frame(width: frameWidht, height: frameHeight)
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .stroke(Color(borderColor), lineWidth: 2)
        }
    }
}
