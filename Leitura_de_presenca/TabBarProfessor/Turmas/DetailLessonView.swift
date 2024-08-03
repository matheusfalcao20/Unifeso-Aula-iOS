//
//  DetailLessonView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI

struct DetailLessonView: View {
    //MARK: - PROPERTY
    
    @State var listLessons : ListTeacherLessons!
    @State var students : [LessonStudent] = []
    @State private var isLoading : Bool = false
    @State private var openQrCode : Bool = false
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(listLessons.lessonName)
                        .font(.largeTitle)
                        .foregroundStyle(.colorTextField)
                        .padding(.top)
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        openQrCode = true
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundStyle(.colorTextField)
                            .font(.title)
                    }
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(students, id: \.self) { aluno in
                        StudentDetailView(studentImage: aluno.userObj.profileImage, type: aluno.userObj.typeUser, name: aluno.userObj.name, register: aluno.userObj.registration, checkBool: true, validationBool: aluno.isPresent)
                            .padding(12)
                    }
                }
            }
            if isLoading {
                
                FALSpinner(isLoading: isLoading)
                
            }
        }
        .fullScreenCover(isPresented: $openQrCode, content: {
            QrCodeView(qrCodeString: listLessons.code)
        })
    }
}

//MARK: - PREVIEW
#Preview {
    DetailClassView()
}
