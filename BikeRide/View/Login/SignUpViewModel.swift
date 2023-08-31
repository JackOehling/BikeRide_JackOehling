

import SwiftUI
import Firebase

final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("Invalid email or password")
            return
        }
        
        let _ = try await AuthentificationManager.shared.createUser(email: email, password: password)
    }
    
}
