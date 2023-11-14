//
//  TabBarViewController.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 05.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        let vc = HomeModuleBuilder.build()
        let homeNVC = UINavigationController(rootViewController: vc)
        let homeBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: nil)
        homeNVC.tabBarItem = homeBarItem
        
        let favouritesVC = FavouritesModuleBuilder.build()
        let favouritesNVC = UINavigationController(rootViewController: favouritesVC)
        let favouritesBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: nil)
        favouritesNVC.tabBarItem = favouritesBarItem
        
        self.viewControllers = [homeNVC, favouritesNVC]
    }

}
