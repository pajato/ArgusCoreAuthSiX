import XCTest
@testable import ArgusCoreAuth


class ArgusCoreAuthTests: XCTestCase {
    class TestAuthenticator : Authenticator {
        func register(withEmail email: String, withPassword password: String, withVerifier verifier: String) -> String {
            return ""
        }
    }

    var interactor = AuthInteractor(withAuthenticator: TestAuthenticator())
    let validEmailAddress = "valid@somewhere.com"
    
    override func setUp() {
        super.setUp()
        interactor = AuthInteractor(withAuthenticator: TestAuthenticator())
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testRegisterWithEmptyEmail_GivesErrorMessage() {
        XCTAssertNotEqual("", interactor.register(withEmail: "", withPassword: "", withVerifier: ""))
    }

    func testRegisterWithEmptyPassword_GivesErrorMessage() {
        XCTAssertNotEqual("", interactor.register(withEmail: validEmailAddress, withPassword: "", withVerifier: ""))
    }

    func testRegisterWithEmptyVerifier_GivesErrorMessage() {
        let email = "somebody@somewhere.com"
        let password = "horses fly south"
        XCTAssertNotEqual("", interactor.register(withEmail: email, withPassword: password, withVerifier: ""))
    }

    func testRegisterWithNonMatchingPasswordAndVerifier_GivesErrorMessage() {
        let email = "somebody@somewhere.com"
        let password = "horses fly south"
        let verifier = "bluebirds ride home"
        XCTAssertNotEqual("", interactor.register(withEmail: email, withPassword: password, withVerifier: verifier))
    }

    func testRegisterWithValidInputs_GivesNoErrorMessage() {
        let email = "me@some.domain"
        let password = "horses fly south"
        let verifier = "horses fly south"
        XCTAssertEqual("", interactor.register(withEmail: email, withPassword: password, withVerifier: verifier))
    }
}
