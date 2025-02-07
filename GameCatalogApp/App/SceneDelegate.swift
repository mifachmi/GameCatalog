//
//  SceneDelegate.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 25/01/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let container = SwinjectInjection.shared.container
        
        let homeUseCase = container.resolve(HomeUseCase.self)!
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        
        let searchUseCase = container.resolve(SearchUseCase.self)!
        let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
        
        let favoriteUseCase = container.resolve(FavoriteUseCase.self)!
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        
        let mainViewController = MainViewController(
            homePresenter: homePresenter,
            searchPresenter: searchPresenter,
            favoritePresenter: favoritePresenter
        )
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
