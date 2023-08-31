//
//  SettingsView.swift
//  BikeRide
//
//  Created by Jack Oehling on 8/30/23.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
        try AuthentificationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthentificationManager.shared.getAuthUser()
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthentificationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "test1"
        try await AuthentificationManager.shared.updatePassword(password: password)
    }
    
    
}

struct SettingsView: View {
    
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        List {
            Button("Sign out") {
                Task {
                    do {
                        try settingsViewModel.signOut()
                    } catch {
                        
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await settingsViewModel.updatePassword()
                        print("password updated")
                    } catch {
                        print("\(error)")
                    }
                }
            }
            
            Button("Reset password") {
                Task {
                    do {
                        try await settingsViewModel.resetPassword()
                        print("password reset")
                    } catch {
                        print("\(error)")
                    }
                }
            }
            
            
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView()
        }
    }
}
