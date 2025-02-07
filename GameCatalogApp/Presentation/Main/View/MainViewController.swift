//
//  MainViewController.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 27/01/25.
//

import UIKit

class MainViewController: UITabBarController {
    
    private let homePresenter: HomePresenter
    private let searchPresenter: SearchPresenter
    private let favoritePresenter: FavoritePresenter
    
    init(homePresenter: HomePresenter, searchPresenter: SearchPresenter, favoritePresenter: FavoritePresenter) {
        self.homePresenter = homePresenter
        self.searchPresenter = searchPresenter
        self.favoritePresenter = favoritePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // to remove extra padding in the tab bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension MainViewController {
    func setupTabBar() {
        
        let homeVC = HomeViewController(homePresenter: homePresenter)
        let searchVC = SearchViewController(searchPresenter: searchPresenter)
        let favoriteVC = FavoriteGameViewController(favoritePresenter: favoritePresenter)
        
        homeVC.tabBarItem = UITabBarItem(
            title: "Catalog",
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        favoriteVC.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: favoriteVC)
        ]
        
        tabBar.barStyle = .default
    }
}
