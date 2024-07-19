//
//  HomeCellView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 08/06/24.
//

import SwiftUI

struct HomeCellView: View {
    //MARK: - PROPERTIES
    
    @State private var clickHeart : Bool = false
    @State private var comment: String = ""
    @State private var playAnimation: Bool = false
    @State private var likeAppear : Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 20){
            Image("landscape")
                .resizable()
                .scaledToFit()
                .onTapGesture(count: 2, perform: {
                    likeAppear = true
                    clickHeart = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        likeAppear = false
                    }
                })
                .overlay {
                    if likeAppear {
                        LottieView(lottieFile: "like")
                    }
                }
            
            Button {
                clickHeart.toggle()
            } label: {
                if !clickHeart {
                    Image(systemName: "heart")
                        .font(.title2)
                } else {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 2)
            
            CustomTextField(placeholder: "Comentar", text: $comment, textColor: .fields, borderColor: .fields, frameWidht: .infinity, frameHeight: 30)
        }//:VStack
    }
}

struct HomeCellView_Preview: PreviewProvider{
    static var previews: some View{
        HomeCellView()
            .previewLayout(.fixed(width: 375, height: 400))
            .padding()
    }
}
