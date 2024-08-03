//
//  ListClassView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI

struct ListClassView: View {
    //MARK: - PROPERTY
    
    @State private var listClass: [ListClass] = []
    @State private var isLoading : Bool = false
    @State private var error : String = ""
    @State private var showAlert : Bool = false
    @State private var showAlertSheet : Bool = false
    @State private var openSheet : Bool = false
    @State private var className : String = ""
    
    //MARK: - FUNCTIONS
    
    //MARK: listClassRequest
    
    func listClassRequest() {
        isLoading = true
        TeacherAPI.listClasses { response in
            isLoading = false
            if response.success {
                listClass = response.listClass
            } else {
                error = response.erroMessage
                showAlert = true
            }
        }
    }
    
    //MARK: formatted date
    
    func formattedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Data inválida"
        }
        
        dateFormatter.dateFormat = "HH:mm - dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    //MARK: Class Name
    
    func creatClass() {
        isLoading = true
        
        var params = [String : Any]()
        params["class_name"] = className
        
        TeacherAPI.creatClass(params: params) { response in
            isLoading = false
            if response.success {
                listClassRequest()
                openSheet = false
                showAlertSheet = true
                error = "Turma adicionada com sucesso"
            } else {
                showAlert = true
                error = response.erroMessage
            }
        }
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Text("Listagem de Turmas")
                        .font(.title)
                        .bold()
                    
                    Button {
                        openSheet = true
                    } label: {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundStyle(.feso)
                            
                            Text("Adicionar turma")
                                .font(.subheadline)
                                .foregroundStyle(.feso)
                        }
                    }
                }
                ScrollView {
                    ForEach(listClass, id: \.self) { item in
                        NavigationLink {
                            DetailClassView(currentClass: item, students: item.students)
                        } label: {
                            ClassroumCardUIView(
                                class_name: item.className,
                                class_date: formattedDate(dateString: item.createdAt)
                            )
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
            if isLoading {
                
                FALSpinner(isLoading: isLoading)
                
            }
        }
        .alert("Atenção",isPresented: $showAlert) {
            
        } message: {
            Text(error)
        }
        
        .alert("Sucesso",isPresented: $showAlertSheet) {
            
        } message: {
            Text(error)
        }
        
        .onAppear {
            listClassRequest()
        }
        .sheet(isPresented: $openSheet) {
            VStack(alignment: .center, spacing: 20){
                Text("Adicionar nova turma")
                    .padding(.top)
                    .font(.largeTitle)
                    
                Text("Nova Turma:")
                CustomTextField(placeholder: "Turma", padding: 12, text: $className, textColor: .gray, textFieldColor: .colorTextField, borderColor: .colorTextField, frameWidht: .infinity, frameHeight: 40, cornerRadius: 6, lineWidth: 1, alignment: .center)
                    .padding(.horizontal)
                
                CustomButton(text: "Adicionar", textColor: .white, textFontSize: 16, backgroundColor: .feso, cornerRadious: 12, frameWidth: 220, frameHeight: 40) {
                    creatClass()
                }
                
                Spacer()
            }
            .padding(.top)
            .presentationDetents([.height(260), .medium])
        }
    }
}

//#Preview {
//    ListClassView()
//}
