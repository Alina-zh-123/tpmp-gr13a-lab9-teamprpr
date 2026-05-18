import SwiftUI

struct CurrencyView: View {
    @Binding var currentScreen: String
    
    let currencies = CurrencyRate.getLocalizedRates()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { currentScreen = "menu" }) {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                        
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 18, weight: .medium))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Image("logo_aurora")
                .resizable()
                .scaledToFit()
                .frame(width: 412)
                .padding(.top, 10)
                .padding(.bottom, 30)
            
            //MARK: - Currency Grid Table
            HStack {
                Text("currency_title").frame(width: 120, alignment: .leading)
                Spacer()
                Text("currency_buy").frame(width: 80, alignment: .center)
                Text("currency_sell").frame(width: 80, alignment: .center)
            }
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.secondary)
            .padding(.horizontal, 35)
            .padding(.bottom, 10)
            
           
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(currencies) { currency in
                        CurrencyCapsule(currency: currency)
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 20)
            }
            
            Spacer()
        }
        .background(Color(white: 0.98).ignoresSafeArea())
    }
}

struct CurrencyCapsule: View {
    var currency: CurrencyRate
    
    var body: some View {
        VStack(spacing: 0) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.black.opacity(0.05))
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(currency.code)
                        .font(.system(size: 18, weight: .bold))
                    Text(currency.name)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                Text(currency.buy)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 80, alignment: .center)
                
                Text(currency.sell)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 80, alignment: .center)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 20)
            .frame(width: 340, height: 70)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        }
    }
}

struct CurrencyRate: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let buy: String
    let sell: String
    
    
    static func getLocalizedRates() -> [CurrencyRate] {
        let lang = Locale.current.languageCode ?? "ru"
        
        switch lang {
        case "en":
            return [
                CurrencyRate(code: "USD", name: "US Dollar", buy: "3.2450", sell: "3.2850"),
                CurrencyRate(code: "EUR", name: "Euro", buy: "3.5120", sell: "3.5650"),
                CurrencyRate(code: "RUB", name: "100 Russian Rubles", buy: "3.4800", sell: "3.5300"),
                CurrencyRate(code: "CNY", name: "10 Chinese Yuan", buy: "4.4500", sell: "4.5200")
            ]
        case "it":
            return [
                CurrencyRate(code: "USD", name: "Dollaro Statunitense", buy: "3.2450", sell: "3.2850"),
                CurrencyRate(code: "EUR", name: "Euro", buy: "3.5120", sell: "3.5650"),
                CurrencyRate(code: "RUB", name: "100 Rubli Russi", buy: "3.4800", sell: "3.5300"),
                CurrencyRate(code: "CNY", name: "10 Yuan Cinesi", buy: "4.4500", sell: "4.5200")
            ]
        default: 
            return [
                CurrencyRate(code: "USD", name: "Доллар США", buy: "3.2450", sell: "3.2850"),
                CurrencyRate(code: "EUR", name: "Евро", buy: "3.5120", sell: "3.5650"),
                CurrencyRate(code: "RUB", name: "100 Рос. рубль", buy: "3.4800", sell: "3.5300"),
                CurrencyRate(code: "CNY", name: "10 Китайский юань", buy: "4.4500", sell: "4.5200")
            ]
        }
    }
}
