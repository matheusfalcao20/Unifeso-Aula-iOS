//
//  ClassView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 05/06/24.
//

import SwiftUI

struct TabBarView: View {
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = false
    
    var body: some View {
        NavigationStack{
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Perfil")
                    }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    TabBarView()
}
