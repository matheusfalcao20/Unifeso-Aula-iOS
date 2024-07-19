//
//  StartView.swift
//  Aula2
//
//  Created by Mohamad Lobo on 01/06/24.
//

import SwiftUI


struct StartView: View {
    //MARK: - PROPERTIES
    
    @State var isActive: Bool = false
    @StateObject var loggedUser = LoggedUser.sharedInstance
    @AppStorage(PreferenceKeys.token.rawValue) var storedToken: String = ""
    @State private var isNavigationActive: Bool = false
    @State private var isNavigationContentActive: Bool = false
    
    //MARK: - FUNC
    
    func getUser() {
        UserAPI.getUser { userResponse in
            if userResponse.success {
                if storedToken.isEmpty {
                    isNavigationContentActive = true
                } else {
                    isNavigationActive = true
                    
                }
            } else {
                isNavigationContentActive = true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                NavigationLink(destination: TabBarView(), isActive: $isNavigationActive){
                    EmptyView()
                }
                
                NavigationLink(
                    destination: ContentView(),
                    isActive: $isNavigationContentActive,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                self.isActive = true
                loggedUser.token = storedToken
                getUser()
                
            }
        }
    }
}

#Preview {
    StartView()
}
