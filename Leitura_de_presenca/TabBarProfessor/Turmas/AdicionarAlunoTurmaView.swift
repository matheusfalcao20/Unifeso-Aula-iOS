//
//  AdicionarAlunoTurmaView.swift
//  Leitura-de-presenca
//  Created by Mohamad Lobo on 19/07/24.

///Se o botao  + do Detalhe  for clicado precisa ser redirecionado para essa tela

import SwiftUI

import SwiftUI

struct AdicionarAlunoTurmaView: View {
    @State private var nome: String = ""
    @State private var sobrenome: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Nome", text: $nome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Sobrenome", text: $sobrenome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    if nome.isEmpty || sobrenome.isEmpty {
                        alertMessage = "Todos os campos devem ser preenchidos."
                        showAlert = true
                    } else {
                        print("Nome: \(nome), Sobrenome: \(sobrenome)")
                      
                    }
                }) {
                    Text("✓")
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 18/255, green: 126/255, blue: 113/255)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage))
                }
            }
            .navigationTitle("Adicionar Aluno")
        }
    }
}

struct AdicionarAlunoTurmaView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarAlunoTurmaView()
    }
}
