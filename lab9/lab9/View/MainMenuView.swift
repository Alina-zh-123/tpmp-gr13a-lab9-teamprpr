import SwiftUI

struct MainMenuView: View {
    @Binding var currentScreen: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image("logo_aurora")
                .resizable()
                .scaledToFit()
                .frame(width: 518) 
                .padding(.bottom, 10)
            
            Text("welcome_text")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.blue)
                .frame(width: 300, height: 50)
                .background(Color.white)
                
            Spacer().frame(height: 20)
            
            CustomMenuButton(title: "menu_accounts") { currentScreen = "accounts" }
            CustomMenuButton(title: "menu_branches") { currentScreen = "branches" }
            CustomMenuButton(title: "menu_currency") { currentScreen = "currency" }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.98).ignoresSafeArea())
    }
}
//MARK: - Custom UI Components
struct CustomMenuButton: View {
    var title: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 300, height: 55)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(27.5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
        }
    }
}
