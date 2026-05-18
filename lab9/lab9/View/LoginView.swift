import SwiftUI

struct LoginView: View {
    //MARK: - Properties
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var login = ""
    @State private var password = ""
    
    //MARK: - Body View
    var body: some View {
        VStack(spacing: 0) {
            Image("logo_aurora")
                .resizable()
                .scaledToFit()
                .frame(width: 518)
                .padding(.top, 60)
            
            VStack(spacing: 16) {
                LoginInputField(placeholder: LocalizedStringKey("login_placeholder"), text: $login)
                LoginInputField(placeholder: LocalizedStringKey("password_placeholder"), text: $password, isSecure: true)
                
                Button(action: {
                    if !login.isEmpty && !password.isEmpty {
                        isLoggedIn = true
                    }
                }) {
                    Text("login_button")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 261, height: 48)
                        .background(Color.blue)
                        .cornerRadius(1000)
                }
                .padding(.top, 24)
            }
            .padding(.top, 50)
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct LoginInputField: View {
    let placeholder: LocalizedStringKey
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .font(.system(size: 16))
        .padding(.horizontal, 16)
        .frame(width: 259, height: 52)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
