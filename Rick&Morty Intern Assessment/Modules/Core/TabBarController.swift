//
//  ViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 18.08.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpTabs()
    }


    func setUpTabs() {
        let charactersListViewController = CharactersListViewController()
        let settingsViewController = SettingsViewController()
        
        charactersListViewController.navigationItem.largeTitleDisplayMode = .automatic
        settingsViewController.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: charactersListViewController)
        let nav2 = UINavigationController(rootViewController: settingsViewController)
        
        let nav1ImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        let nav1Image = UIImage(systemName: "person.3.sequence", withConfiguration: nav1ImageConfiguration)
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: nav1Image, tag: 1)
        
        let nav2ImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        let nav2Image = UIImage(systemName: "slider.horizontal.3", withConfiguration: nav2ImageConfiguration)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: nav2Image, tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: true)
        tabBar.barStyle = .black
    }
}

