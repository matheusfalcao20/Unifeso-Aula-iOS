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
            ScrollView {}
        }
        .padding()
    }
}

#Preview {
    AulaView()
}
