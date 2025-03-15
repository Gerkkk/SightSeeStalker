//
//  CustomTabBarController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private enum Constants {
        static let cornerRadius = CGFloat(48)
        static let boarderWidth = CGFloat(1.5)
        static let bottomOffset = CGFloat(15)
        static let tabBarHeight = CGFloat(90)
        static let tabBarWidth = CGFloat(380)
        
        static let tabBarBackgroundColor = UIColor.viewColor
        static let unselectedItemTintColor = UIColor.textSupporting
        static let tintColor = UIColor.customGreen
        static let borderColor = UIColor.viewEdging
    }
    
    private let floatingTabBar = UITabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupFloatingTabBar()
        removeSystemTabBar()
    }
    
    private func setupTabs() {
        let vcNews = NewsAssembly.build()
        let vcExplore = ExploreAssembly.build()
        let vcMap = MapAssembly.build()
        let vcHome = HomeAssembly.build()
        
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
        
        floatingTabBar.layer.cornerRadius = Constants.cornerRadius
        floatingTabBar.layer.borderWidth = Constants.boarderWidth
        floatingTabBar.layer.borderColor = Constants.borderColor.cgColor
        floatingTabBar.tintColor = Constants.tintColor
        floatingTabBar.unselectedItemTintColor = Constants.unselectedItemTintColor
        
        floatingTabBar.layer.masksToBounds = true
        floatingTabBar.clipsToBounds = true
        
        floatingTabBar.itemPositioning = .centered
        
        floatingTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingTabBar)
        view.bringSubviewToFront(floatingTabBar)
        floatingTabBar.backgroundColor = Constants.tabBarBackgroundColor
        floatingTabBar.barTintColor = Constants.tabBarBackgroundColor
        floatingTabBar.isTranslucent = false

        floatingTabBar.pinBottom(to: view, Constants.bottomOffset)
        floatingTabBar.pinCenterX(to: view)
        floatingTabBar.setHeight(Constants.tabBarHeight)
        floatingTabBar.setWidth(Constants.tabBarWidth)
    }
    
    private func removeSystemTabBar() {
        view.backgroundColor = .clear
        self.tabBar.isHidden = true
        self.tabBar.removeFromSuperview()
        
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
