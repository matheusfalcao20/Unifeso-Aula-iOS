//
//  AdicionarAulaView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

struct ClassRoom: Hashable {
    var id: String;
    var code: String;
    var created_at: String
    var lesson_name: String
}



import SwiftUI



struct AdicionarAulaView: View {
    @State var classrooms: [ClassRoom] = []
    
    func get_class_room(){
        getClassromAPI(token: "token 6b68a2f1f5348c141c37cecd8b7f4831776bd92a"){ [self]rest in
           classrooms = rest
        }
    }
    
    var body: some View {
        Text("Listagem de aulas")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
        ScrollView {
            ForEach(classrooms, id: \.self) { item in
                ClassroumCardUIView(
                    class_name: item.lesson_name,
                    class_number: item.id,
                    class_date: item.created_at
                )
            }
        }.onAppear {
            get_class_room()
        }
    }
}

#Preview {
    AdicionarAulaView()
}
