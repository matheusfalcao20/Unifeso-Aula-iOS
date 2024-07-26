
//  AdicionarTurmaView.swift
//  Leitura-de-presenca

//  Created by Mohamad Lobo on 19/07/24.
import SwiftUI
import Alamofire


import SwiftUI

struct AdicionarTurmaView: View {
    @State private var turma: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var likeUp = [Bool](repeating: false, count: 5)
    @State private var comments = [String](repeating: "", count: 5)
    @State private var showAnimation = [Bool](repeating: false, count: 5)
    @State private var isSheet : Bool = false

    var body: some View {
        VStack {
            Button {
                isSheet = true
            } label: {
                Spacer()
                Text("+")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 18/255, green: 126/255, blue: 113/255)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    )
                    .padding([.top, .trailing], 20)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(comments.indices, id: \.self) { index in
                        HStack {
                            TextField("Turmas", text: $comments[index])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 30) // Adjust width if needed
                            
                            Button(action: {
                                deleteItem(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.black)
                                    .padding(.leading, 8)
                            }
                        }
                        .padding(.horizontal)
                    }
//                    VStack {
//                                      ForEach(comments.indices, id: \.self) { index in
//                                          HStack {
//                                              TextField("Turmas", text: $comments[index])
//                                                  .textFieldStyle(RoundedBorderTextFieldStyle())
//                                                  .frame(width: 300, height: 30)
//                                                  .padding()
//                                              
//                                              Button(action: {
//                                                  deleteItem(at: index)
//                                              }) {
//                                                  Image(systemName: "trash")
//                                                      .foregroundColor(.white)
//                                                      .padding(10)
//                                                      .background(Color.red)
//                                                      .clipShape(Circle())
//                                              }
      
                    
                }
            }
        }
        .sheet(isPresented: $isSheet) {
            AdicionarAlunoTurmaView()
        }
    }
    
    private func deleteItem(at index: Int) {
        withAnimation {
            comments.remove(at: index)
        }
    }
}

struct AdicionarTurmaView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarTurmaView()
    }
}
