//
//  ContentView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    
    enum Sou: String, CaseIterable, Identifiable {
        case Aluno, Professor
        var id: Self { self }
    }


    @State private var selectedSou : Sou = .Aluno
    @State private var matricula: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var isLoading = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Image("Unifeso")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 130)
                HStack{
                    Text("Sou...")
                    Picker("", selection: $selectedSou) {
                        Text("Aluno").tag(Sou.Aluno)
                        Text("Professor").tag(Sou.Professor)
                    } .accentColor(.black).pickerStyle(.inline)
                        .frame(width: 200)
                }
                    
                    
                    if selectedSou == Sou.Aluno{
                        CustomTextField(placeholder: "Matricula", padding: 10, text: $matricula, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                        
                        CustomTextField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                    } else{
                        CustomTextField(placeholder: "Email", padding: 10, text: $email, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                        
                        CustomTextField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                    }
                CustomButton(text: "Salvar Alterações", textColor: .white, textFontSize: 20, backgroundColor: UIColor.feso, cornerRadious: 10, frameWidth: 200, frameHeight: 40, action: {})                .disabled(isLoading).padding(.top, 20)
                
                
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
