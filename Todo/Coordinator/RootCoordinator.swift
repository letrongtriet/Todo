//
//  RootCoordinator.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

class RootCoordinator {
    // MARK: - Private properties
    private let window: UIWindow
    private let storageService: StorageService
    private let navigationController: UINavigationController

    // MARK: - Init
    init(
        window: UIWindow,
        storageService: StorageService
    ) {
        self.window = window
        self.storageService = storageService

        navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Coordinator
extension RootCoordinator: Coordinator {
    func start() {
        let viewModel = TodoViewModel(storageService: storageService)
        let viewController = TodoViewController(viewModel: viewModel)

        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
