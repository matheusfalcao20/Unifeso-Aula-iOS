//
//  ClassroumCardUIView.swift
//  Leitura_de_presenca
//
//  Created by 08-L05-D-054875 on 20/07/24.
//

import SwiftUI

struct ClassroumCardUIView: View {
    var class_name: String;
    var class_date: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.feso)
        .overlay {
            HStack {
                Image(systemName: "graduationcap.fill")
                VStack(alignment: .leading) {
                    Text("Aula: " + class_name)
                        .fontWeight(.semibold)
                    Text(class_date)
                        .italic()
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "")
            }
            .padding()
            .foregroundColor(.white)
        }
        .frame(width: 350, height: 60)
    }
}

#Preview {
    ClassroumCardUIView(
        class_name: "Turma IOS",
        class_date: "12/05/192"
    )
}
