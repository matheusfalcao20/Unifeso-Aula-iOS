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
            ListClassView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Turmas")
                }
            TurmasView()
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarProfessorView()
}
