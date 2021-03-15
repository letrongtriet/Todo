//
//  LoginViewModel.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Combine
import Foundation

protocol LoginViewModelDelegate {
    func showRootView()
}

class LoginViewModel {
    // MARK: - Observables
    @Published public private(set) var state: State
    var delegate: LoginViewModelDelegate?

    // MARK: - Private properties
    private let biometricService: BiometricService

    // MARK: - Init
    init(
        biometricService: BiometricService,
        delegate: LoginViewModelDelegate
    ) {
        self.biometricService = biometricService
        self.state = .noSignedUp
        self.delegate = delegate
        checkState()
    }

    // MARK: - Public methods
    func handleButtonTapped() {
        biometricService.authenticateUser { [weak self] isSuccess in
            guard let self = self else { return }
            self.biometricService.userDidSignUp()
            self.delegate?.showRootView()
        }
    }

    func checkState() {
        if biometricService.canAuthenticateUser() {
            state = biometricService.didUserSignUp() ? .signedUp : .noSignedUp
        } else {
            delegate?.showRootView()
        }
    }
}

extension LoginViewModel {
    enum State {
        case noSignedUp
        case signedUp

        var title: String {
            switch self {
            case .signedUp:
                return "Welcome back"
            case .noSignedUp:
                return "Welcome to another TODO app"
            }
        }

        var buttonTitle: String {
            switch self {
            case .signedUp:
                return "Log In"
            case .noSignedUp:
                return "Enable Secure Login"
            }
        }
    }
}
