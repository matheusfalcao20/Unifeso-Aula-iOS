//
//  DetailClass.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI

struct DetailClassView: View {
    //MARK: - PROPERTY
    
    @State var currentClass: ListClass!
    @State var students: [Students] = []
    @State private var isLoading: Bool = false
    @State private var openSheet: Bool = false
    @State private var registrationSting: String = ""
    @State private var showAlert: Bool = false
    @State private var error: String = ""
    @State private var data = Date.now
    
    @Environment(\.dismiss) var dismiss
    
    //MARK: - FUNCTIONS
    
    func addStudent() {
        isLoading = true
        
        var params = [String: Any]()
        params["class_teacher"] = currentClass.id
        params["registration"] = registrationSting
        
        TeacherAPI.addStudent(params: params) { response in
            isLoading = false
            if response.success {
                showAlert = true
                error = "Aluno adicionado com sucesso!"
                openSheet = false
            } else {
                showAlert = true
                error = response.erroMessage
            }
        }
    }
    
    func fetchData() async {
        data = Date.now
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(currentClass.className)
                        .font(.title)
                        .foregroundStyle(.colorTextField)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        openSheet = true
                    } label: {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundStyle(.feso)
                            
                            Text("Adicionar aluno")
                                .font(.subheadline)
                                .foregroundStyle(.feso)
                        }
                    }
                }
                .padding(.horizontal)
                List(students, id: \.self) { aluno in
                    StudentDetailView(studentImage: aluno.profileImage, type: aluno.typeUser, name: aluno.name, register: aluno.registration, checkBool: false, validationBool: false)
                        .padding(12)
                }
                .refreshable {
                    await fetchData()
                }
                .listStyle(.plain)
            }
            if isLoading {
                FALSpinner(isLoading: isLoading)
            }
        }
        .sheet(isPresented: $openSheet) {
            VStack(alignment: .center, spacing: 20) {
                Text("Adicionar aluno")
                    .padding(.top)
                    .font(.largeTitle)
                
                Text("Matrícula do aluno:")
                CustomTextField(placeholder: "Matrícula", padding: 12, text: $registrationSting, textColor: .gray, textFieldColor: .colorTextField, borderColor: .colorTextField, frameWidht: .infinity, frameHeight: 40, cornerRadius: 6, lineWidth: 1, alignment: .center)
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
                
                CustomButton(text: "Adicionar", textColor: .white, textFontSize: 16, backgroundColor: .feso, cornerRadious: 12, frameWidth: 220, frameHeight: 40) {
                    addStudent()
                }
                
                Spacer()
            }
            .padding(.top)
            .presentationDetents([.height(260), .medium])
        }
        .alert("Atenção", isPresented: $showAlert) {
            Button("OK") {
                // Use the presentationMode to dismiss the current view
                dismiss.callAsFunction()
            }
        } message: {
            Text(error)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    DetailClassView()
}
