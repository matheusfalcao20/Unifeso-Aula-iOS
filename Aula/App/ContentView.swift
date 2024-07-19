//
//  ContentView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 31/05/24.
//

import SwiftUI
import SwiftHash

struct ContentView: View {
    //MARK: - PROPERTY
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var eyeAction : Bool = false
    @State private var isAnimating : Bool = false
    @State private var isLoading : Bool = false
    @State private var showAlert : Bool = false
    @State private var isNavigationActive : Bool = false
    @State private var error : String = ""
    
    //MARK: - FUNC
    
    func login() {
        
        isLoading = true
        
        var params = [String : Any]()
        params["email"] = email
        params["password"] = MD5(password)
        
        isLoading = true
        UserAPI.signIn(params: params) { response in
            
            isLoading = false
            
            if response.success {
                
                isLoading = true
                
                UserAPI.getUser { userResponse in
                    isLoading = false
                    
                    if userResponse.success {
                        
                        DispatchQueue.main.async {
                            self.isNavigationActive = true
                        }
                        
                    } else {
                        
                        error = userResponse.erroMessage
                        DispatchQueue.main.async {
                            self.showAlert = true
                        }
                        
                    }
                }
                
            } else {
                isLoading = false
                error = response.erroMessage
                DispatchQueue.main.async {
                    self.showAlert = true
                    print("Error signing in: \(error)")
                }
            }
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            ZStack {
                VStack(alignment: .center, spacing: 20){
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan, Color.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                            .frame(width: 135, height: 135)
                        Image(systemName: "swift")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }//:ZStack
                    .cornerRadius(40)
                    .shadow(color: Color.fields.opacity(0.7) ,radius: 8, x: 1, y: 2)
                    .scaleEffect(isAnimating ? 1 : 0)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    CustomTextField(placeholder: "Nome", text: $email, textColor: .fields, borderColor: .fields, frameWidht: .infinity, frameHeight: 40)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                    
                    if eyeAction == false{
                        CustomSecureField(placeholder: "Senha", text: $password, textColor: .fields, borderColor: .fields, frameWidht: .infinity, frameHeight: 40)
                            .padding(.horizontal)
                            .textCase(.lowercase)
                            .overlay {
                                HStack{
                                    Spacer()
                                    Button {
                                        eyeAction.toggle()
                                    } label: {
                                        Image(systemName: "eye")
                                            .foregroundStyle(.fields)
                                    }
                                }
                                .padding(.trailing, 29)
                            }
                    } else {
                        CustomTextField(placeholder: "Senha", text: $password, textColor: .fields, borderColor: .fields, frameWidht: .infinity, frameHeight: 40)
                            .padding(.horizontal)
                            .textCase(.lowercase)
                            .overlay {
                                HStack{
                                    Spacer()
                                    Button {
                                        eyeAction.toggle()
                                    } label: {
                                        Image(systemName: "eye")
                                            .foregroundStyle(.fields)
                                    }
                                }
                                .padding(.trailing, 29)
                            }
                    }
                    CustomButton(
                        text: "Enviar",
                        textColor: .white,
                        textFontSize: 20,
                        backgroundColor: .systemBlue,
                        cornerRadious: 20,
                        frameWidth: 200,
                        frameHeight: 40
                    ) {
                       login()
                    }
                    
                }//:VStack
                NavigationLink(destination: TabBarView(), isActive: $isNavigationActive){
                    EmptyView()
                }
                
                if isLoading {
                    
                    FALSpinner(isLoading: isLoading)
                    
                }
            }//:ZStack
            .onAppear{
                withAnimation(.easeInOut(duration: 1.5)){
                    isAnimating = true
                }
            }
            .alert(error, isPresented: $showAlert) {
                Button("Ok") { }
            }
        }//:NavigationView
        .navigationBarBackButtonHidden()
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
