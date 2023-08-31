//
//  ContentView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/13/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var loginModel = LoginViewModel()
    @Binding var showSignView: Bool
    
    var body: some View {
            VStack{
                
                TextField("Email", text: $loginModel.email)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(Color(.gray))
                
                SecureField("Password", text: $loginModel.password)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 300, height: 1)
                    .foregroundColor(Color(.gray))
                
                Button {
                    Task {
                        do {
                            try await loginModel.signIn()
                            showSignView = false
                            print("Logged in")
                        } catch {
                            
                        }
                    }

                } label: {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .background(Color(UIColor.label))
                }
                
                
                NavigationLink {
                    SignUpView(showSignView: $showSignView)
                } label: {
                    Text("Don't have an account? Sign Up.")
                        .font(.caption)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor.label))
                }
                
            }
            .navigationTitle("Sign in")
            .frame(width: 300)
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(showSignView: .constant(false))
        }
    }
}
