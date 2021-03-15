//
//  LoginCoordinator.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func showRootView()
}

class LoginCoordinator {
    // MARK: - Public properties
    var delegate: LoginCoordinatorDelegate?

    // MARK: - Private properties
    private let window: UIWindow
    private let biometricService: BiometricService

    // MARK: - Init
    init(
        window: UIWindow,
        biometricService: BiometricService,
        delegate: LoginCoordinatorDelegate
    ) {
        self.window = window
        self.biometricService = biometricService
        self.delegate = delegate
    }

    // MARK: - Private methods
    private func showLoginView() {
        let viewModel = LoginViewModel(
            biometricService: biometricService,
            delegate: self
        )
        let viewController = LoginViewController(viewModel: viewModel)

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension LoginCoordinator: Coordinator {
    func start() {
        showLoginView()
    }
}

extension LoginCoordinator: LoginViewModelDelegate {
    func showRootView() {
        delegate?.showRootView()
    }
}
