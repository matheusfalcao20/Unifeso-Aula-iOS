//
//  TabBarAlunoView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct TabBarAlunoView: View {
    var body: some View {
        TabView {
            AulaView()
                .tabItem {
                    Image(systemName: "graduationcap")
                    Text("Aulas")
                }
            
            PerfilView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
        }
    }
}

#Preview {
    TabBarAlunoView()
}
