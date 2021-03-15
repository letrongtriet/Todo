//
//  AppCoordinator.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

class AppCoordinator {
    // MARK: - Private properties
    private var loginCoordinator: LoginCoordinator?
    private var rootCoordinator: RootCoordinator?

    private let window: UIWindow
    private let storageService: StorageService
    private let biometricService: BiometricService

    // MARK: - Init
    init(
        window: UIWindow,
        storageService: StorageService,
        biometricService: BiometricService
    ) {
        self.window = window
        self.storageService = storageService
        self.biometricService = biometricService
    }

    // MARK: - Private methods
    private func showRoot() {
        rootCoordinator = RootCoordinator(
            window: window,
            storageService: storageService
        )
        rootCoordinator?.start()
    }

    private func showLogin() {
        loginCoordinator = LoginCoordinator(
            window: window,
            biometricService: biometricService,
            delegate: self
        )
        loginCoordinator?.start()
    }
}

// MARK: - Coordinator
extension AppCoordinator: Coordinator {
    func start() {
        showLogin()
    }
}

// MARK: - LoginCoordinatorDelegate
extension AppCoordinator: LoginCoordinatorDelegate {
    func showRootView() {
        showRoot()
    }
}
