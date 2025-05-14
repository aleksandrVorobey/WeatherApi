//
//  SceneDelegate.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let weatherVC = WeatherRouter.createModule()
        let navController = UINavigationController(rootViewController: weatherVC)

        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

