//
//  ViewController.swift
//  Countries
//
//  Created by Emre Sarı on 5.08.2022.
//

import UIKit

class NavTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let favs = UINavigationController(rootViewController: FavoritesViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        favs.tabBarItem.image = UIImage(systemName: "star")
        home.title = "Home"
        favs.title = "Saved"
        setViewControllers([home, favs], animated: true)
        self.tabBar.tintColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
    }


}

