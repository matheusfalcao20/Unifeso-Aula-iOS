//
//  AulaView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct AulaView: View {
    var body: some View {
        VStack {
            Text("Suas aulas")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
                .frame(height: 50)
            ScrollView {
                VStack() {
                    ForEach(classes, id: \.self) { cl in
                        ClassCard(className: cl.title, classTime: cl.time, hasPresence: cl.hasPresence)
                            .frame(height: 64)
                        Spacer()
                            .frame(height: 16)
                    }
                }
            }
            Button (action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Ler presença")
                    .fontWeight(.semibold)
            })
            .foregroundColor(.feso)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.feso, lineWidth: 2)
            }
            
        }
        .padding()
    }
}

#Preview {
    AulaView()
}
