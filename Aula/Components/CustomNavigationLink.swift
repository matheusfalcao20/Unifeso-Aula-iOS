//
//  CustomNavigationLink.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI

struct CustomNavigationLink<Destination: View>: View {
    //MARK: - PROPERTY
    
    var text: String
    var textColor: UIColor
    var textFontSize: Double
    var backgroundColor: UIColor
    var cornerRadius: Double
    var frameWidth: Double
    var frameHeight: Double
    var action: Destination
    
    //MARK: - BODY
    var body: some View {
        NavigationLink(destination: action) {
            Text(text)
                .font(.system(size: textFontSize))
                .frame(width: frameWidth, height: frameHeight)
                .foregroundColor(Color(textColor))
                .background(Color(backgroundColor))
                .cornerRadius(cornerRadius)
        }
    }
}
