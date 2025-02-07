//
//  FavoritePresenter.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import UIKit
import RxSwift

protocol FavoritePresenterDelegate: AnyObject {
    func getFavoriteGames(count: Int)
}

class FavoritePresenter {
    private let favoriteUseCase: FavoriteUseCase
    private let disposeBag = DisposeBag()
    let router = FavoriteRouter()
    
    private(set) var favoriteGames: [GameModel] = []
    weak var delegate: FavoritePresenterDelegate?
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteGames() {
        favoriteUseCase.getFavoriteGames()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] games in
                self?.delegate?.getFavoriteGames(count: games.count)
                self?.favoriteGames = games
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
    }
    
    func showDetailGame(from viewController: UIViewController, gameId: Int) {
        router.navigateToDetail(from: viewController, gameId: gameId)
    }
}
