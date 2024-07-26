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
    @State private var isLoading = false
    @State private var alertMode = false
    @State private var nextScreen = false
    @State private var error: String = ""
    
    var body: some View {
<<<<<<< HEAD
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
                    
                    if selectedSou == Sou.Aluno {
                        CustomTextField(placeholder: "Matricula", padding: 10, text: $matricula, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40).padding(.bottom, 10)
                        
                        CustomTextField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                        
                        CustomButton(text: "Entrar", textColor: .white, textFontSize: 20, backgroundColor: UIColor.feso, cornerRadious: 10, frameWidth: 200, frameHeight: 40, action: {
                            if matricula.isEmpty || password.isEmpty {
                                error = "Matrícula e senha não podem estar vazios"
                                alertMode = true
                            } else {
                                loginAluno()
                            }
                        })
                        .padding(.top, 20)
                        .alert(error, isPresented: $alertMode) {
                            Button("Ok") {}
                        } message: {
                            Text(error)
                        }
                        
                        .fullScreenCover(isPresented: $nextScreen) {
                              TabBarAlunoView()
                       }
                        
                    } else {
                        CustomTextField(placeholder: "Email", padding: 10, text: $email, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40).padding(.bottom, 10)
                        
                        CustomTextField(placeholder: "Senha", padding: 10, text: $password, textColor: .gray, borderColor: Color(red: 18/255, green: 126/255, blue: 113/255), frameWidht: 300, frameHeight: 40)
                        
                        CustomButton(text: "Entrar", textColor: .white, textFontSize: 20, backgroundColor: UIColor.feso, cornerRadious: 10, frameWidth: 200, frameHeight: 40, action: {
                            if email.isEmpty || password.isEmpty {
                                error = "Email e senha não podem estar vazios"
                                alertMode = true
                            } else {
                                loginProfessor()
                            }
                        })
                        .padding(.top, 20)
                        .alert(error, isPresented: $alertMode) {
                            Button("Ok") {}
                        } message: {
                            Text(error)
                        }
                        
                        .fullScreenCover(isPresented: $nextScreen) {
                              TabBarProfessorView()
                       }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func loginAluno() {
        isLoading = true
        
        var params = [String: Any]()
        params["registration"] = matricula
        params["birthday"] = password // Supondo que o usuário insere a data de aniversário diretamente no campo senha no formato correto

        print("Tentando login com parâmetros: \(params)")
        
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
        
        print("Tentando login com parâmetros: \(params)")
        
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
=======
        VStack {
         AdicionarTurmaView()
        // TabBarProfessorView()
        
        
>>>>>>> 4778bed (Helo iza)
        }
    }
}

#Preview {
    ContentView()
}

