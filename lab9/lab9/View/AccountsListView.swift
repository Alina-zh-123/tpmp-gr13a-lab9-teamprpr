
import SwiftUI

struct AccountsListView: View {
    @Binding var currentScreen: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { currentScreen = "menu" }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Image("logo_aurora")
                .resizable()
                .scaledToFit()
                .frame(width: 518)
                .padding(.top, 20)
            
            Spacer().frame(height: 40)
            
            VStack(spacing: 24) {
              
                AccountDetailRow(label: "account_number", value: "25276191767")
                AccountDetailRow(label: "account_type", value: "account_type_savings")
                AccountDetailRow(label: "account_balance", value: "1 234 567 BYN")
            }
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}
//MARK: - Subviews
struct AccountDetailRow: View {
    let label: LocalizedStringKey
    let value: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(Color.gray.opacity(0.6))
                .padding(.leading, 16)
            
            Text(value) 
                .font(.system(size: 16, weight: .medium))
                .frame(width: 344, height: 48, alignment: .leading)
                .padding(.leading, 16)
                .background(
                    Capsule()
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                )
        }
    }
}
