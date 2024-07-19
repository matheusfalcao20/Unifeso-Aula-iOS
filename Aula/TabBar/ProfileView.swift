//
//  ProfileView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 08/06/24.
//

import SwiftUI

struct ProfileView: View {
    //MARK: - PROPERTIES
    
    @AppStorage("username") var storedName: String = ""
    private let itens = [
        "Perfil",
        "Amigos",
        "Seguidores",
        "Sair"
    ]
    
    private let images = [
        "person.fill",
        "person.2.fill",
        "person.line.dotted.person.fill",
        "rectangle.portrait.and.arrow.forward.fill"
    ]
    
    private var itemImages: [(String, String)] {
        Array(zip(itens, images))
    }
    
    @State private var isNavigateToLogin : Bool = false
    
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = false
    
    
    //MARK: - FUNCTIONS
    func handleItemTap(item: String) {
        if item == "Sair" {
            let preferences = UserDefaults.standard

            preferences.removeObject(forKey: PreferenceKeys.token.rawValue)
            
            LoggedUser.clear()
            
            isNavigateToLogin = true
        } else {
            print("\(item) tapped")
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Olá, \(LoggedUser.sharedInstance.user.name)")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.leading)
            Spacer()
            ForEach(itemImages.indices, id: \.self) { index in
                let item = itemImages[index]
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 40)
                    .foregroundStyle(.gray.opacity(0.3))
                    .overlay {
                        HStack {
                            Image(systemName: item.1)
                            Text(item.0)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.horizontal)
                    }
                    .onTapGesture {
                        handleItemTap(item: item.0)
                    }
            }
            .padding(.horizontal)
            Spacer()
        }
        .background {
            NavigationLink(destination: ContentView(), isActive: $isNavigateToLogin){
                EmptyView()
            }
        }
    }
}

#Preview {
    ProfileView()
}
