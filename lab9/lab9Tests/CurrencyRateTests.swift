import XCTest
@testable import lab9

final class CurrencyRateTests: XCTestCase {
    
    func testGetLocalizedRatesReturnsCorrectCountForAllLanguages() {
        // Test English
        let enRates = CurrencyRate.getLocalizedRates(lang: "en")
        XCTAssertEqual(enRates.count, 4, "Should return exactly 4 currency rates for English")
        XCTAssertEqual(enRates[0].code, "USD")
        XCTAssertEqual(enRates[0].name, "US Dollar")
        
        // Test Italian
        let itRates = CurrencyRate.getLocalizedRates(lang: "it")
        XCTAssertEqual(itRates.count, 4, "Should return exactly 4 currency rates for Italian")
        XCTAssertEqual(itRates[0].code, "USD")
        XCTAssertEqual(itRates[0].name, "Dollaro Statunitense")
        
        // Test Default / Russian
        let ruRates = CurrencyRate.getLocalizedRates(lang: "ru")
        XCTAssertEqual(ruRates.count, 4, "Should return exactly 4 currency rates for Russian")
        XCTAssertEqual(ruRates[0].code, "USD")
        XCTAssertEqual(ruRates[0].name, "Доллар США")
        
        // Test fallback (e.g. invalid code)
        let fallbackRates = CurrencyRate.getLocalizedRates(lang: "es")
        XCTAssertEqual(fallbackRates.count, 4, "Should fallback to Russian and return exactly 4 rates")
        XCTAssertEqual(fallbackRates[0].name, "Доллар США")
    }
    
    func testCurrencyRateModelProperties() {
        let rate = CurrencyRate(code: "BYN", name: "Белорусский рубль", buy: "1.0", sell: "1.0")
        XCTAssertEqual(rate.code, "BYN")
        XCTAssertEqual(rate.name, "Белорусский рубль")
        XCTAssertEqual(rate.buy, "1.0")
        XCTAssertEqual(rate.sell, "1.0")
        XCTAssertNotNil(rate.id)
    }
    
    func testDefaultGetLocalizedRates() {
        let rates = CurrencyRate.getLocalizedRates()
        XCTAssertEqual(rates.count, 4)
    }
}
