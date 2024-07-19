//
//  teste.swift
//  Aula2
//
//  Created by Mohamad Lobo on 14/06/24.
//

import SwiftUI

struct teste: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ForEach(0 ..< 5) { item in
                    Text("item \(item)")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    teste()
}
