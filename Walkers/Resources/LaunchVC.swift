//
//  ViewController.swift
//  Walkers
//
//  Created by Никита Васильев on 09.10.2023.
//

import UIKit
class LaunchVC: UIViewController {

    private let icon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 250, width: 200, height: 200))
        imageView.image = UIImage.init(named: "icon")
        return imageView
    }()
    
    private lazy var welcomeText: UILabel = {
        let label = UILabel(frame: CGRect(x: 115, y: 900, width: 300, height: 30))
        label.text = "Find your Walker!"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        return label
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addBackground()
        addViews()
        animatew()
    }
  
    
    func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "wP_launch")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8 , execute: {
            self.animatew()
        })
    }
    
    func addViews() {
        view.addSubview(icon)
        view.addSubview(welcomeText)
    }
    private func animatew() {
        UIView.animate(withDuration: 2 ) {
            self.welcomeText.frame = CGRect(x: 115, y: 750, width: 300, height: 30)
        } completion: { done in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                let profileViewController = ProfileViewController()
                let mapViewController = MapViewController()
                
                let profileNavViewController = UINavigationController(rootViewController: profileViewController)
                let mapNavViewController = UINavigationController(rootViewController:mapViewController)
          
                mapNavViewController.tabBarItem.title = "Поиск"
                mapNavViewController.tabBarItem.image = UIImage(named: "search-3")
                
                profileNavViewController.tabBarItem.title = "Мой профиль"
                profileNavViewController.tabBarItem.image = UIImage(named: "user")
                
                mapNavViewController.tabBarItem.title = "О приложении"
                mapNavViewController.tabBarItem.image = UIImage(named: "info")
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [mapNavViewController, profileNavViewController ]
                tabBarController.tabBar.backgroundColor = .white
                tabBarController.modalTransitionStyle = .crossDissolve
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true)
            }
            )
        }
    }

}

extension LaunchVC {
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [color, UIColor.systemGray6.cgColor]
        view.layer.insertSublayer(gradient, at: 100)
    }
}
