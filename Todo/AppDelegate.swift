//
//  AppDelegate.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light

        appCoordinator = AppCoordinator(
            window: window!,
            storageService: .init(),
            biometricService: .init()
        )
        appCoordinator.start()

        return true
    }
}

