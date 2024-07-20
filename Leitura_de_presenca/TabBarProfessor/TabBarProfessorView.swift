//
//  TabBarProfessorView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct TabBarProfessorView: View {
    var body: some View {
        TabView {
            TurmasView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Turmas")
                }
            
            AulaProfessorView()
                .tabItem {
                    Image(systemName: "graduationcap")
                    Text("Aulas")
                }
            
            PerfilProfessorView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
        }
    }
}

#Preview {
    TabBarProfessorView()
}
