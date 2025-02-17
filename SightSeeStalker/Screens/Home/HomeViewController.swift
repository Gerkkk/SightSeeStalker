//
//  HomeViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class HomeViewController: UIViewController {

    var avatar: CustomImageView = CustomImageView(radius: 90, image: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.backgroundCol
        
//        view.addSubview(avatar)
//        avatar.pinCenterX(to: view.centerXAnchor)
//        avatar.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 0)
        
    }


}



