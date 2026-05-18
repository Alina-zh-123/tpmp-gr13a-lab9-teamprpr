
import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var currentScreen = "menu"

    //MARK: - Body View
    var body: some View {
        Group {
            if isLoggedIn {
                if currentScreen == "menu" {
                    MainMenuView(currentScreen: $currentScreen)
                } else if currentScreen == "accounts" {
                    AccountsListView(currentScreen: $currentScreen)
                } else if currentScreen == "branches" {
                    BranchMapView(currentScreen: $currentScreen)
                } else if currentScreen == "currency" {
                    CurrencyView(currentScreen: $currentScreen)
                }
            } else {
                LoginView()
            }
        }
        .animation(.default, value: isLoggedIn)
        .animation(.default, value: currentScreen)
    }
}
