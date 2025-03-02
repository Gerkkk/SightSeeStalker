//
//  CustomTabBarController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

//class CustomTabBarController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureTabs()
//    }
//    
//    private func configureTabs (){
//        let vcNews = NewsViewController()
//        let vcExplore = ExploreViewController()
//        let vcMap = MapViewController()
//        let vcHome = HomeViewController()
//        
//        
//        vcNews.tabBarItem.image = UIImage(named: "News")
//        vcExplore.tabBarItem.image = UIImage(named: "MagGlass")
//        vcMap.tabBarItem.image = UIImage(named: "Earth")
//        vcHome.tabBarItem.image = UIImage(named: "Person")
//        
//        vcNews.title = "News"
//        vcExplore.title = "Explore"
//        vcMap.title = "Map"
//        vcHome.title = "Home"
//        
//        
//       // vcNews.tabBarItem.
//        
//        let navNews = UINavigationController(rootViewController: vcNews)
//        navNews.hidesBottomBarWhenPushed = true
//        navNews.isNavigationBarHidden = true
//        let navExplore = UINavigationController(rootViewController: vcExplore)
//        navExplore.hidesBottomBarWhenPushed = true
//        navExplore.isNavigationBarHidden = true
//        let navMap = UINavigationController(rootViewController: vcMap)
//        navMap.hidesBottomBarWhenPushed = true
//        navMap.isNavigationBarHidden = true
//        let navHome = UINavigationController(rootViewController: vcHome)
//        navHome.isNavigationBarHidden = true
//        navHome.hidesBottomBarWhenPushed = true
//        
//        tabBar.unselectedItemTintColor = UIColor.iconNotChosen
//        tabBar.tintColor = UIColor.customGreen
//        tabBar.backgroundColor = UIColor.viewColor
//        
//        
//        self.tabBar.layer.cornerRadius = 50
//        self.tabBar.layer.borderWidth = 1
//        self.tabBar.layer.borderColor = UIColor.viewEdging.cgColor
//        
//
//        
//        self.setViewControllers([navNews, navExplore, navMap, navHome], animated: true)
//    }
//}


class CustomTabBarController: UITabBarController {
    
    private let floatingTabBar = UITabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupFloatingTabBar()
        removeSystemTabBar()
    }
    
    private func setupTabs() {
        let vcNews = NewsViewController()
        let vcExplore = ExploreViewController()
        let vcMap = MapViewController()
        //TODO: id from keychain'
        let vcHome = HomeViewController(person: PersonModel(id: 0, name: "", tag: "", status: "", follows: [], followersNum: 0, avatar: nil))
        
        vcNews.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "News"), tag: 0)
        vcExplore.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "MagGlass"), tag: 1)
        vcMap.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "Earth"), tag: 2)
        vcHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Person"), tag: 3)
        
        let navControllers = [
            UINavigationController(rootViewController: vcNews),
            UINavigationController(rootViewController: vcExplore),
            UINavigationController(rootViewController: vcMap),
            UINavigationController(rootViewController: vcHome)
        ]
        
        for i in navControllers {
            i.isNavigationBarHidden = true
            i.hidesBottomBarWhenPushed = true
        }
        
        self.setViewControllers(navControllers, animated: false)
    }
    
    private func setupFloatingTabBar() {
        floatingTabBar.delegate = self
        floatingTabBar.items = self.tabBar.items
        floatingTabBar.selectedItem = self.tabBar.selectedItem
        
        floatingTabBar.layer.cornerRadius = 48
        floatingTabBar.layer.borderWidth = 1.5
        floatingTabBar.layer.borderColor = UIColor.viewEdging.cgColor
        floatingTabBar.tintColor = UIColor.customGreen
        floatingTabBar.unselectedItemTintColor = UIColor.textSupporting
        
        floatingTabBar.layer.masksToBounds = true
        floatingTabBar.clipsToBounds = true
        
        floatingTabBar.itemPositioning = .centered
        
        floatingTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingTabBar)
        view.bringSubviewToFront(floatingTabBar)
        floatingTabBar.backgroundColor = UIColor.viewColor
        floatingTabBar.barTintColor = UIColor.viewColor
        floatingTabBar.isTranslucent = false

        floatingTabBar.pinBottom(to: view, 15)
        floatingTabBar.pinCenterX(to: view)
        floatingTabBar.setHeight(90)
        floatingTabBar.setWidth(380)
    }
    
    private func removeSystemTabBar() {
        view.backgroundColor = .clear
        self.tabBar.isHidden = true
        self.tabBar.removeFromSuperview()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.tabBar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)


        for subview in self.view.subviews {
            if String(describing: type(of: subview)).contains("UITabBarControllerBackground") {
                subview.removeFromSuperview()
            }
        }
        
        for subview in self.tabBar.subviews {
            if subview.backgroundColor != UIColor.viewColor && subview.backgroundColor != .clear && subview.backgroundColor != UIColor.backgroundCol {
                subview.removeFromSuperview()
            }
        }
    }
}
