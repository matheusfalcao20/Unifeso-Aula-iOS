//
//  AulaView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI
import VisionKit

struct AulaView: View {
    //MARK: - PROPERTY

    @State private var listLessons : [ListStudentLessons] = []
    @State private var error : String = ""
    @State private var isLoading : Bool = false
    @State private var showAlert : Bool = false
    
    //MARK: - FUNCTIONS
    
    //MARK: request Lessons
    
    func listStudents() {
        isLoading = true
        StudentAPI.listLessons { [self]response in
            isLoading = false
            if response.success {
                listLessons = response.listStudentLessons
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
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text("Suas aulas")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                    .frame(height: 50)
                ScrollView(.vertical, showsIndicators: false){
                    VStack() {
                        ForEach(listLessons, id: \.self) { lessons in
                            ClassCard(className: lessons.lessonName, classTime: formattedDate(dateString: lessons.createdAt), hasPresence: lessons.isPresented)
                                .frame(height: 64)
                            Spacer()
                                .frame(height: 16)
                        }
                    }
                }
                NavigationLink {
                    
                    ScannerView()
                    
                } label: {
                    Text("Ler presença")
                        .fontWeight(.semibold)
                        .foregroundColor(.feso)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.feso, lineWidth: 2)
                        }
                }
            }
            .padding()
            
            if isLoading {
                
                FALSpinner(isLoading: isLoading)
                
            }
        }
        .alert("Atenção",isPresented: $showAlert) {
            //
        } message: {
            Text(error)
        }
        .onAppear {
            listStudents()
        }
    }
}

//MARK: - PREVIEW
#Preview {
    AulaView()
}
