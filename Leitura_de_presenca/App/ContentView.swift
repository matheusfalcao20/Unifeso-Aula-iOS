//
//  AulaView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI
import SwiftHash

struct ContentView: View {
    
    enum Sou: String, CaseIterable, Identifiable {
        case Aluno, Professor
        var id: Self { self }
    }

    @State private var selectedSou: Sou = .Aluno
    @State private var matricula: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var dateText: String = ""
    @State private var isLoading = false
    @State private var alertMode = false
    @State private var nextScreen = false
    @State private var eyeToogle : Bool = false
    @State private var error: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image("Unifeso")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 130)
                    
                    HStack {
                        Text("Sou...")
                        Picker("", selection: $selectedSou) {
                            Text("Aluno").tag(Sou.Aluno)
                            Text("Professor").tag(Sou.Professor)
                        }
                        .accentColor(.black)
                        .pickerStyle(.inline)
                        .frame(width: 200)
                    }
                    
                    if selectedSou == .Aluno{
                        CustomTextField(placeholder: "Matrícula", padding: 10, text: $matricula, textColor: .gray, textFieldColor: .colorTextField, borderColor: .feso, frameWidht: 300, frameHeight: 40, cornerRadius: 12, lineWidth: 1, alignment: .center)
                            .padding(.bottom, 10)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled()
                        
                        
                        CustomTextField(placeholder: "Data de nascimento", padding: 10, text: $dateText, textColor: .gray, textFieldColor: .colorTextField, borderColor: .feso, frameWidht: 300, frameHeight: 40, cornerRadius: 12, lineWidth: 1, alignment: .center)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .keyboardType(.numberPad)
                            .onChange(of: dateText) { newValue in
                                dateText = applyDateMask(to: newValue)
                            }
                        
                    } else {
                        CustomTextField(placeholder: "Email", padding: 10, text: $email, textColor: .gray, textFieldColor: .colorTextField, borderColor: .feso, frameWidht: 300, frameHeight: 40, cornerRadius: 12, lineWidth: 1, alignment: .center )
                            .padding(.bottom, 10)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                        
                        if eyeToogle == false {
                            CustomSecureField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, textFieldColor: .colorTextField, borderColor: .feso, frameWidht: 300, frameHeight: 40, cornerRadius: 12, lineWidth: 1, alignment: .center)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .overlay(
                                    Image(systemName: "eye")
                                        .font(.subheadline)
                                        .onTapGesture {
                                            eyeToogle = true
                                        }
                                        .padding(.trailing)
                                    ,alignment: .trailing
                                )
                        } else {
                            CustomTextField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, textFieldColor: .colorTextField, borderColor: .feso, frameWidht: 300, frameHeight: 40, cornerRadius: 12, lineWidth: 1, alignment: .center)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .overlay(
                                    Image(systemName: "eye.slash")
                                        .font(.subheadline)
                                        .onTapGesture {
                                            eyeToogle = false
                                        }
                                        .padding(.trailing)
                                    ,alignment: .trailing
                                )
                        }
                        
                    }
                    
                    CustomButton(text: "Entrar", textColor: .white, textFontSize: 20, backgroundColor: UIColor.feso, cornerRadious: 10, frameWidth: 200, frameHeight: 40, action: {
                        validarCampos()
                    })
                    .padding(.top, 20)
                    .alert("Atenção", isPresented: $alertMode) {
                        //
                    } message: {
                        Text(error)
                    }
                }//: VSTACK
                
                if isLoading {
                    
                    FALSpinner(isLoading: isLoading)
                    
                }
                
                if selectedSou == .Aluno {
                    NavigationLink(destination: TabBarAlunoView(), isActive: $nextScreen){
                        EmptyView()
                    }
                } else {
                    NavigationLink(destination: TabBarProfessorView(), isActive: $nextScreen){
                        EmptyView()
                    }
                }
            }//: ZSTACK
            
        }
        .navigationBarBackButtonHidden()
    }
    
    func applyDateMask(to text: String) -> String {
        let numbersOnly = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let maxLength = 8
        
        var result = ""
        var index = 0
        for char in numbersOnly {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(char)
            index += 1
            
            if index == maxLength {
                break
            }
        }
        return result
    }
    
    func formatDate(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func validarCampos() {
        if selectedSou == .Aluno {
            if matricula.isEmpty || dateText.isEmpty {
                error = "Matrícula e data de nascimento não podem estar vazios"
                alertMode = true
            } else {
                loginAluno()
            }
        } else if selectedSou == .Professor {
            if email.isEmpty || password.isEmpty {
                error = "Email e senha não podem estar vazios"
                alertMode = true
            } else {
                loginProfessor()
            }
        }
    }
    
    func loginAluno() {
        isLoading = true
        
        guard let formattedDate = formatDate(from: dateText) else {
            error = "Formato de data inválido. Use dd/MM/yyyy"
            alertMode = true
            isLoading = false
            return
        }
        
        var params = [String: Any]()
        params["registration"] = matricula
        params["birthday"] = formattedDate
        
        UserAPI.signIn(params: params, userType: .aluno) { responseLogin in
            isLoading = false
            
            if responseLogin.success {
                isLoading = true
                UserAPI.getUser { userResponse in
                    isLoading = false
                    
                    if userResponse.success {
                        DispatchQueue.main.async {
                            nextScreen = true
                        }
                    } else {
                        print(userResponse.erroMessage)
                        DispatchQueue.main.async {
                            error = userResponse.erroMessage
                            alertMode = true
                        }
                    }
                }
            } else {
                print(responseLogin.erroMessage)
                DispatchQueue.main.async {
                    error = responseLogin.erroMessage
                    alertMode = true
                }
            }
        }
    }
    
    func loginProfessor() {
        isLoading = true
        
        var params = [String: Any]()
        params["email"] = email
        params["password"] = MD5(password)
            
        UserAPI.signIn(params: params, userType: .professor) { responseLogin in
            isLoading = false
            
            if responseLogin.success {
                isLoading = true
                UserAPI.getUser { userResponse in
                    isLoading = false
                    
                    if userResponse.success {
                        DispatchQueue.main.async {
                            nextScreen = true
                        }
                    } else {
                        print(userResponse.erroMessage)
                        DispatchQueue.main.async {
                            error = userResponse.erroMessage
                            alertMode = true
                        }
                    }
                }
            } else {
                print(responseLogin.erroMessage)
                DispatchQueue.main.async {
                    error = responseLogin.erroMessage
                    alertMode = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

