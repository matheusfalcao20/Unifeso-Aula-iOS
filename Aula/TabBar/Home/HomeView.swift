//
//  HomeView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 08/06/24.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    
    
    
    //MARK: - BODY
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0 ..< 5) { item in
                    HomeCellView()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
