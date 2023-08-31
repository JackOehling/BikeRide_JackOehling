//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import Firebase

struct RootView: View {
    
    @State private var signInView: Bool = false
    
    var body: some View {
        ZStack {
            ContentView()
        }.onAppear {
            let authUser = try? AuthentificationManager.shared.getAuthUser()
            self.signInView = authUser == nil ? false : true
        }
        .fullScreenCover(isPresented: $signInView) {
            NavigationStack {
                LoginView(showSignView: $signInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RootView()
        }
    }
}
