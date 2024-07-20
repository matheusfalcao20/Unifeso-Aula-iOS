//
//  ProfileTabsView.swift
//  login-screen
//
//  Created by 08-L05-D-054876 on 14/06/24.
//

import SwiftUI

struct ClassCard: View {
    var className: String
    var classTime: String
    var hasPresence = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.gray)
        .overlay {
            HStack {
                Image(systemName: "graduationcap.fill")
                VStack(alignment: .leading) {
                    Text(className)
                        .fontWeight(.semibold)
                    Text(classTime)
                        .italic()
                        .font(.subheadline)
                }
                Spacer()
                if hasPresence {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                }
            }
            .padding()
            .foregroundColor(.white)
        }
        
       
        
    }
}

struct ProfileTabsView_Preview: PreviewProvider {
    
    static var previews: some View {
        ClassCard(
            className: "Banco de dados", classTime: "19:00 - 21/10/2023"
        )
            .previewLayout(.fixed(width: 500, height: 100))
            .padding()
    }
}

