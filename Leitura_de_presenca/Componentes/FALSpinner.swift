//
//  FALSpinner.swift
//  orion-ios
//
//  Created by Mohamad Lobo on 28/03/24.
//

import SwiftUI

struct FALSpinner: View {
    
    @State var isLoading: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea()
            
            if isLoading {
                ProgressView()
                    .tint(.gray)
                    .scaleEffect(2)
            }
        }
        .opacity(isLoading ? 1 : 0)
    }
}

struct FALSpinner_Previews: PreviewProvider {
    static var previews: some View {
        FALSpinner(isLoading: true)
        FALSpinner(isLoading: false)
    }
}
