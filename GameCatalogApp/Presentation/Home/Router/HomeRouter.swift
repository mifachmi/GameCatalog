//
//  HomeRouter.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import UIKit

class HomeRouter {
    func navigateToDetail(from viewController: UIViewController, gameId: Int) {
        let container = SwinjectInjection.shared.container
        let detailUseCase = container.resolve(DetailUseCase.self)!
        let detailPresenter = DetailPresenter(detailUseCase: detailUseCase)
        let detailViewController = DetailGameViewController(gameId: gameId, detailPresenter: detailPresenter)
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
