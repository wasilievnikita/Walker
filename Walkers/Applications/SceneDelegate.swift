//
//  SceneDelegate.swift
//  Walkers
//
//  Created by Никита Васильев on 09.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let profileViewController = ProfileViewController()
        let mapViewController = MapViewController()
        
        let profileNavViewController = UINavigationController(rootViewController: profileViewController)
        let mapNavViewController = UINavigationController(rootViewController:mapViewController)
  
        
        mapNavViewController.tabBarItem.title = "Поиск"
        mapNavViewController.tabBarItem.image = UIImage(named: "search-3")
        
        profileNavViewController.tabBarItem.title = "Мой профиль"
        profileNavViewController.tabBarItem.image = UIImage(named: "user")
        
//        mapNavViewController.tabBarItem.title = "О приложении"
//        mapNavViewController.tabBarItem.image = UIImage(named: "info")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mapNavViewController, profileNavViewController ]
        tabBarController.tabBar.backgroundColor = .white
        
        window.backgroundColor = .white
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            Thread.sleep(forTimeInterval: 2.0)
            // Override point for customization after application launch.
            return true
        }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}
