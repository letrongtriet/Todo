//
//  BiometricService.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Foundation
import LocalAuthentication

class BiometricService {
    // MARK: - Private properties
    private let userDefault = UserDefaults.standard
    private let context = LAContext()
    private var error: NSError?

    // MARK: - Public methods
    func userDidSignUp() {
        userDefault.setValue(true, forKey: AppPantry.StorageKey.userDidSignUp)
    }

    func didUserSignUp() -> Bool {
        userDefault.bool(forKey: AppPantry.StorageKey.userDidSignUp)
    }

    func canAuthenticateUser() -> Bool {
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func authenticateUser(completion: @escaping (Bool) -> Void) {
        let reason = "Log in to use app"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) { success, error in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
