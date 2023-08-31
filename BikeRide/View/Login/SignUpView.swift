

import SwiftUI
import Firebase


struct SignUpView: View {
    
    @StateObject private var signUpModel = SignUpViewModel()
    @Binding var showSignView: Bool
    
    var body: some View {
        VStack {
            
            TextField("Email", text: $signUpModel.email)
                .textFieldStyle(.plain)
            
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(Color(.gray))
            
            SecureField("Password", text: $signUpModel.password)
                .textFieldStyle(.plain)
            
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(Color(.gray))
            
            Button {
                Task {
                    do {
                        try await signUpModel.signUp()
                        showSignView = false
                        print("Logged in")
                    } catch {
                        
                    }
                }
            } label: {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .background(Color(UIColor.label))
            }
        }.navigationTitle("Sign Up")
            .frame(width: 300)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView(showSignView: .constant(false))
        }
    }
}
