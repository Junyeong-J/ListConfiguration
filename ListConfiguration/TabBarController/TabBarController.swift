//
//  TabBarController.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        
        let settingVC = SettingViewController()
        let nav1 = UINavigationController(rootViewController: settingVC)
        nav1.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "book"), tag: 0)
        
        let talkVC = TalkViewController()
        let nav2 = UINavigationController(rootViewController: talkVC)
        nav2.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2], animated: true)
    }
    
}
