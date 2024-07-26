
//  DetalheTurmaView.swift
//  Leitura-de-presenca
//  Created by Mohamad Lobo on 19/07/24.

// se o botao + for clicado ir para AdicionarAlunoTurmaView:
import SwiftUI

struct DetalheTurmaView: View {
    
    @State private var listagemAlunos = [String]()
    @State private var adicionarAlunos = [String]()
    @State private var removerAlunos = [String]()
    @State private var alertMode = false
    @State private var isNavigationContentActive: Bool = false
    @State var clickButton : Bool?
    
    var body: some View {
        VStack {
            Button {
                clickButton = true
                print(clickButton)
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
            }
            .padding(.bottom, 10)
        }
        
        
        
        
        //            Button(action: {
        //                if listagemAlunos.isEmpty && adicionarAlunos.isEmpty && removerAlunos.isEmpty {
        //                    alertMode = true
        //                } else {
        //                    print("Listagem: \(listagemAlunos), Adicionar: \(adicionarAlunos), Remover: \(removerAlunos)")
        //                }
        //            }) {
        //            }
        //            .alert(isPresented: $alertMode) {
        //                Alert(
        //                    title: Text("Campo vazio"),
        //                    message: Text("Os campos não podem estar vazios."),
        //                    dismissButton: .default(Text("Ok"))
        //                )
        //            }
        //        }
        //        .padding()
        //    }
        //
        //    func adicionarAluno() {
        //        adicionarAlunos.append("Novo Aluno")
        //        print("Adicionar Aluno: \(adicionarAlunos)")
        //    }
        //
        //    func removerAluno() {
        //        if !adicionarAlunos.isEmpty {
        //            adicionarAlunos.removeLast()
        //        } else if !removerAlunos.isEmpty {
        //            removerAlunos.removeLast()
        //        }
        //        print("Remover Aluno: \(removerAlunos)")
        //    }
        //}
    }
    
}
//struct DetalheTurmaView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetalheTurmaView()
//    }
//}

