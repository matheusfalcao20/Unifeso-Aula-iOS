//
//  PerfilView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct PerfilView: View {
    
    @State private var matricula: String = ""
    @State private var email: String = ""
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var nextScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                
                Text("nome sobrenome")
                    .font(.footnote)
                    .padding(.vertical, 30)
                
                HStack {
                    CustomTextField(placeholder: "matrícula", padding: 10, text: $matricula, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                    
                    Button {
                    } label: {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                    }
                }
                
                HStack {
                    CustomTextField(placeholder: "email", padding: 10, text: $email, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 20)

                NavigationLink(destination: TabBarAlunoView()) {
                    Text("Alterar senha").underline().foregroundStyle(.gray).font(.footnote)
                }
                
                .padding(.leading, 240)
                
                
                CustomButton(text: "Salvar Alterações", textColor: .white, textFontSize: 20, backgroundColor: UIColor.feso, cornerRadious: 10, frameWidth: 200, frameHeight: 40, action: {})                .disabled(isLoading).padding(.top, 20)
                
                Button {
                    if email.isEmpty {
                        alertMessage = "Credenciais inválidas. Por favor, verifique seu e-mail e senha."
                    } else {
                        isLoading = true
                    }
                } label: {
                    
                }
                
                if isLoading {
                    ProgressView("")
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
    }
}

#Preview {
    PerfilView()
}
