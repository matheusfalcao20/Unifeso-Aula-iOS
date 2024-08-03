//
//  StudentDetailView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI

struct StudentDetailView: View {
    //MARK: - PROPERTY
    
    var studentImage : String = ""
    
    var type : String = ""
    
    var name : String = ""
    
    var register : String = ""
    
    var checkBool : Bool = false
    
    var validationBool : Bool = false
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).cornerRadius(12)
            HStack {
                if studentImage == "" {
                    Image(.unifeso)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 70)
                        .clipShape(Circle())
                        .padding(.trailing)
                } else {
                    Image(studentImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 70)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
                
                Spacer()

                VStack {
                    if type == "STUDENT" {
                        Text("Estudante")
                            .font(.title2)
                            .foregroundStyle(.colorTextField)
                            .fontWeight(.medium)
                    } else if type == "TEACHER" {
                        Text("Professor")
                            .font(.title2)
                            .foregroundStyle(.colorTextField)
                    }
                    
                    Text(name)
                        .font(.title3)
                        .foregroundStyle(.colorTextField)
                    
                    Text("Matrícula: \(register)")
                        .font(.subheadline)
                        .foregroundStyle(.colorTextField)

                }
                
                // Verifica se checkBool é true
                if checkBool {
                    // Verifica se validationBool é true ou false
                    if validationBool {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .font(.title)
                    } else {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(width: .infinity, height: 80)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.colorTextField,lineWidth: 2)
        )
    }
}

//MARK: - PREVIEW
struct StudentDetailView_Preview : PreviewProvider {
    static var previews: some View{
        StudentDetailView(type: "a" ,name: "a", checkBool: true, validationBool: true)
            .previewLayout(.fixed(width: 400, height: 200))
            .padding()
    }
}
