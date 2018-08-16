//
//  ArgusCoreAuth.swift
//  ArgusCoreAuth
//
//  Created by Paul Reilly on 8/14/18.
//  Copyright © 2018 pajato. All rights reserved.
//

import Foundation
import ValidationComponents

protocol Authenticator {
    func register(withEmail email: String, withPassword password: String, withVerifier verifier: String) -> String
    //func login(withEmail email: String, withPassword password: String) -> String
    //func logout(withEmail email: String) -> String
}

class AuthInteractor : Authenticator {
    let extAuth : Authenticator
    init(withAuthenticator authenticator: Authenticator) {
        extAuth = authenticator
    }

    func register(withEmail email: String, withPassword password: String, withVerifier verifier: String) -> String {
        if isInvalidEmail(email) {
            return "The given email address is not valid. It should be of the form: abc@some.domain"
        }
        let result = validatePassword(password, verifier)
        return result != "" ? result : extAuth.register(withEmail: email, withPassword: password, withVerifier: verifier)
    }
    
    private func isInvalidEmail(_ email: String) -> Bool {
        let predicate = EmailPredicate()
        return !predicate.evaluate(with: email)
    }

    private func validatePassword(_ password: String, _ verifier: String) -> String {
        if password.count < 10 {
            return "The password must contain at least ten (10) characters!"
        }
        if verifier.count < 10 {
            return "The password verifier must contain at least ten (10) characters!"
        }
        if password != verifier {
            return "The password and it's verifier must match!"
        }
        return ""
    }
}
