import XCTest

final class LoginUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // Reset login state and force English for stable testing
        app.launchArguments.append("-isLoggedIn")
        app.launchArguments.append("false")
        app.launchArguments.append("-AppleLanguages")
        app.launchArguments.append("(en)")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLoginViewInitialElements() {
        // Check for the bank logo image
        let logo = app.images["logo_aurora"]
        XCTAssertTrue(logo.exists)
        
        // Verify input fields
        let loginField = app.textFields["Login"]
        XCTAssertTrue(loginField.exists)
        
        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.exists)
        
        // Verify submit button
        let signInButton = app.buttons["Sign In"]
        XCTAssertTrue(signInButton.exists)
    }
    
    func testLoginValidationEmptyFields() {
        let signInButton = app.buttons["Sign In"]
        signInButton.tap()
        
        // If login/password are empty, we should stay on the Login page (i.e. Sign In button remains visible)
        XCTAssertTrue(app.buttons["Sign In"].exists)
    }
    
    func testSuccessfulLoginFlow() {
        let loginField = app.textFields["Login"]
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign In"]
        
        // Input user and pass
        loginField.tap()
        loginField.typeText("aurora_user")
        
        passwordField.tap()
        passwordField.typeText("secure_password")
        
        // Perform login
        signInButton.tap()
        
        // Validate transition to Main Menu
        let welcomeText = app.staticTexts["Welcome!"]
        XCTAssertTrue(welcomeText.exists)
        
        let myAccountsButton = app.buttons["My Accounts"]
        XCTAssertTrue(myAccountsButton.exists)
    }
}
