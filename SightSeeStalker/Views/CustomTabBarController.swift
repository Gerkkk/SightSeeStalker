//
//  CustomTabBarController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    private func configureTabs (){
        let vcNews = NewsViewController()
        let vcExplore = ExploreViewController()
        let vcMap = MapViewController()
        let vcHome = HomeViewController()
        
        
        vcNews.tabBarItem.image = UIImage(named: "News")
        vcExplore.tabBarItem.image = UIImage(named: "MagGlass")
        vcMap.tabBarItem.image = UIImage(named: "Earth")
        vcHome.tabBarItem.image = UIImage(named: "Person")
        
        vcNews.title = "News"
        vcExplore.title = "Explore"
        vcMap.title = "Map"
        vcHome.title = "Home"
        
        
       // vcNews.tabBarItem.
        
        let navNews = UINavigationController(rootViewController: vcNews)
        navNews.hidesBottomBarWhenPushed = true
        navNews.isNavigationBarHidden = true
        let navExplore = UINavigationController(rootViewController: vcExplore)
        navExplore.hidesBottomBarWhenPushed = true
        navExplore.isNavigationBarHidden = true
        let navMap = UINavigationController(rootViewController: vcMap)
        navMap.hidesBottomBarWhenPushed = true
        navMap.isNavigationBarHidden = true
        let navHome = UINavigationController(rootViewController: vcHome)
        navHome.isNavigationBarHidden = true
        navHome.hidesBottomBarWhenPushed = true
        
        tabBar.unselectedItemTintColor = UIColor.iconNotChosen
        tabBar.tintColor = UIColor.customGreen
        tabBar.backgroundColor = UIColor.viewColor
        
        
        self.tabBar.layer.cornerRadius = 50
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.viewEdging.cgColor
        

        
        self.setViewControllers([navNews, navExplore, navMap, navHome], animated: true)
    }
}

