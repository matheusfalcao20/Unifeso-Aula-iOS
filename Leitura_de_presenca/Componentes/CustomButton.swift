//
//  CustomButton.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI

struct CustomButton: View {
    //MARK: - PROPERTY
    
    var text : String
    var textColor : UIColor
    var textFontSize : Double
    var backgroundColor : UIColor
    var cornerRadious : Double
    var frameWidth : Double
    var frameHeight : Double
    var action : () -> Void
    
    //MARK: - BODY
    var body: some View {
       
        Button(action: action) {
           Text(text)
                .frame(width: frameWidth, height: frameHeight)
                .foregroundStyle(Color(textColor))
                .background(Color(backgroundColor))
                .cornerRadius(cornerRadious)
        }
    }
}
