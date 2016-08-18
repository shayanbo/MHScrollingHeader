//
//  ViewController.swift
//  ScrollingHeaderDemo
//
//  Created by shayanbo on 16/8/18.
//  Copyright © 2016年 mx. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
    }

    private func setupChildViewControllers() {

        let top: CGFloat = (44 - 25) * 0.5
        let wrapWithNavigationController = { (rootViewController: UIViewController) -> UINavigationController in
            UINavigationController(rootViewController: rootViewController)
        }

        let homeVC = UIViewController()
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: top, left: 0, bottom: -top, right: 0)
        homeVC.tabBarItem.image = UIImage(named: "tabbar-home-icon")
        homeVC.tabBarItem.selectedImage = UIImage(named: "tabbar-home-icon-highlighted")!.imageWithRenderingMode(.AlwaysOriginal)

        let searchVC = UIViewController()
        searchVC.tabBarItem.imageInsets = UIEdgeInsets(top: top, left: 0, bottom: -top, right: 0)
        searchVC.tabBarItem.image = UIImage(named: "tabbar-search-icon")
        searchVC.tabBarItem.selectedImage = UIImage(named: "tabbar-search-icon-highlighted")!.imageWithRenderingMode(.AlwaysOriginal)

        let cameraVC = UIViewController()
        cameraVC.tabBarItem.imageInsets = UIEdgeInsets(top: top, left: 0, bottom: -top, right: 0)
        cameraVC.tabBarItem.image = UIImage(named: "tabbar-camera-icon")
        cameraVC.tabBarItem.selectedImage = UIImage(named: "tabbar-camera-icon-highlighted")!.imageWithRenderingMode(.AlwaysOriginal)

        let starVC = UIViewController()
        starVC.tabBarItem.imageInsets = UIEdgeInsets(top: top, left: 0, bottom: -top, right: 0)
        starVC.tabBarItem.image = UIImage(named: "tabbar-activity-icon")
        starVC.tabBarItem.selectedImage = UIImage(named: "tabbar-activity-icon-highlighted")!.imageWithRenderingMode(.AlwaysOriginal)

        let mineVC = MineViewController()
        mineVC.tabBarItem.imageInsets = UIEdgeInsets(top: top, left: 0, bottom: -top, right: 0)
        mineVC.tabBarItem.image = UIImage(named: "tabbar-profile-icon")
        mineVC.tabBarItem.selectedImage = UIImage(named: "tabbar-profile-icon-highlighted")!.imageWithRenderingMode(.AlwaysOriginal)

        viewControllers = [wrapWithNavigationController(homeVC),
                           wrapWithNavigationController(searchVC),
                           wrapWithNavigationController(cameraVC),
                           wrapWithNavigationController(starVC),
                           wrapWithNavigationController(mineVC)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
