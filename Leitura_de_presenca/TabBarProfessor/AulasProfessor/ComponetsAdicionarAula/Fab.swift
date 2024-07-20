//
//  Fab.swift
//  Leitura_de_presenca
//
//  Created by 08-L05-D-054875 on 20/07/24.
//

import SwiftUI

struct Fab: View {
    var callback: () -> Void
    var body: some View {

        Button(action: {
            callback()
        },
            label: {
            Image(systemName: "plus")
                .frame(width: 60,height: 60)
                .background(.green)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        )
    }
}

#Preview {
    Fab(
        callback: {
            
        }
    )
}
