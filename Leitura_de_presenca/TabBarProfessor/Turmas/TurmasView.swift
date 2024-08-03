//
//  TurmasView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI

struct TurmasView: View {
    //MARK: - PROPERTY
    
    @State private var listLesson: [ListTeacherLessons] = []
    @State private var listClass : [ListClass] = []
    @State private var isLoading : Bool = false
    @State private var error : String = ""
    @State private var showAlert : Bool = false
    @State private var showAlertSheet : Bool = false
    @State private var openSheet : Bool = false
    @State private var selectedClassId: Int? = nil
    
    //MARK: - FUNCTIONS
    
    //MARK: listLessonsRequest
    
    func listLessonsRequest() {
        isLoading = true
        TeacherAPI.listLessons() { response in
            isLoading = false
            if response.success {
                listLesson = response.listTeacherLessons
            } else {
                error = response.erroMessage
                showAlert = true
            }
        }
    }
    
    //MARK: LIST CLASS
    
    func listClassRequest() {
        isLoading = true
        TeacherAPI.listClasses { response in
            isLoading = false
            if response.success {
                listClass = response.listClass
                if selectedClassId == nil, let firstClass = listClass.first {
                    selectedClassId = firstClass.id
                }
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
    
    //MARK: Creat Lesson
    
    func creatLesson() {
        isLoading = true
        
        var params = [String : Any]()
        params["class_teacher"] = selectedClassId

        TeacherAPI.creatLesson(params: params) { response in
            isLoading = false
            if response.success {
                error = "Aula adicionada com sucesso"
                showAlertSheet = true
                listLessonsRequest()
            } else {
                error = response.erroMessage
                showAlert = true
            }
        }
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Text("Listagem de Aula")
                        .font(.title)
                    .bold()
                    
                    Spacer()
                    
                    Button {
                        openSheet = true
                    } label: {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundStyle(.feso)
                            Text("Adicionar aula")
                                .font(.subheadline)
                                .foregroundStyle(.feso)
                        }
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(listLesson, id: \.self) { item in
                        NavigationLink {
                            DetailLessonView(listLessons: item, students: item.students)
                        } label: {
                            ClassroumCardUIView(
                                class_name: item.lessonName,
                                class_date: formattedDate(dateString: item.createdAt)
                            )
                        }
                        .padding(.vertical, 12)
                    }
                }
            }//: VSTACK
            if isLoading {
                
                FALSpinner(isLoading: isLoading)
                
            }
        }//: ZSTACK
        .sheet(isPresented: $openSheet) {
            VStack(alignment: .center, spacing: 20) {
                Text("Deseja adicionar qual aula ?")
                    .font(.title)
                    .padding(.top)
                
                Picker("Selecione a turma", selection: $selectedClassId) {
                    ForEach(listClass, id: \.id) { classItem in
                        Text(classItem.className).tag(classItem.id as Int?)
                            .foregroundStyle(.colorTextField)
                    }
                }
                .accentColor(.colorTextField)
                .pickerStyle(.automatic)
                
                CustomButton(text: "Adicionar", textColor: .white, textFontSize: 16, backgroundColor: .feso, cornerRadious: 12, frameWidth: 220, frameHeight: 40) {
                    creatLesson()
                }
                Spacer()
            }//: VSTACK
            .presentationDetents([.height(200), .medium])
        }
        .alert("Atenção", isPresented: $showAlert) {
            Button("Ok") {}
        } message: {
            Text(error)
        }
        .alert(error, isPresented: $showAlertSheet) {
            Button("Ok") {
                openSheet = false
            }
        } message: {
            Text("")
        }
        .onAppear {
            listLessonsRequest()
            listClassRequest()
        }
    }
}

#Preview {
    TurmasView()
}
