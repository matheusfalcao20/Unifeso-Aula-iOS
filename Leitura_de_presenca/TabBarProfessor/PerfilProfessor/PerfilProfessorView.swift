//
//  PerfilProfessorView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI
import PhotosUI

struct PerfilProfessorView: View {
    
    @State private var email: String = LoggedUser.sharedInstance.user.email
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var nextScreen = false
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
            NavigationStack {
                VStack {
                    selectedImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .clipShape(Circle())
                        // .rotationEffect(Angle(degrees: 180))
                    
                    Button {
                        

                    } label: {
                        PhotosPicker("Selecionar foto", selection: $pickerItem, matching: .images)
                            .foregroundStyle(.gray).font(.footnote).padding(.top, 10)
                    }
                    .onChange(of: pickerItem) {
                        Task {
                            selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
                        }
                    }
                    
                    Text(LoggedUser.sharedInstance.user.name)
                        .font(.footnote)
                        .padding(.vertical, 30)
                    
                    HStack {
                        Text(email)
                            .padding(10).frame(width: 300, height: 40, alignment: .leading).foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 17)
                                .stroke(Color(red: 18/255, green: 126/255, blue: 113/255), lineWidth: 2)
                            )
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.black)
                        }
                        
                        // criar a mudança de email
                    }
                    .padding(.vertical, 20)

                    NavigationLink(destination: ChangePassword()) {
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
    
//    func changePassword() {
//        VStack {
//            CustomTextField(placeholder: "Email", padding: 10, text: $email, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
//        }
//    }
}

struct ChangePassword: View {
    
    @State private var email: String = LoggedUser.sharedInstance.user.email
    
    var body: some View {
        VStack {
            CustomTextField(placeholder: "Email", padding: 10, text: $email, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
        }
    }
}

#Preview {
    PerfilProfessorView()
}
