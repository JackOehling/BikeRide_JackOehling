

import SwiftUI
import Firebase

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("Invalid email or password")
            return
        }
        
        let _ = try await AuthentificationManager.shared.signIn(email: email, password: password)
    }
    
}
