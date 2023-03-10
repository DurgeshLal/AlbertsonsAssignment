//
//  SceneDelegate.swift
//  AlbertsonsAssignment
//
//  Created by Durgesh Lal on 1/25/23.
//

import UIKit
import AlbertsonsApplicationBootstrap
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var coordinator: AppCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController, container: ApplicationBootstrap.createApplicationBootstrap())
        coordinator?.start()
        
        self.window = UIWindow(windowScene: sceneWindow)
        self.window?.rootViewController = navigationController
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        self.window?.isHidden = false
    }
}
