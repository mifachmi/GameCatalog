//
//  HomePresenter.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import UIKit
import RxSwift

protocol HomePresenterOutput: AnyObject {
    func willStartLoading()
    func didFinishLoading()
    func didGetGames(_ games: [GameModel])
    func didFailGetGames(with error: Error)
}

class HomePresenter {
    private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()
    weak var output: HomePresenterOutput?
    let router = HomeRouter()
    
    private(set) var games: [GameModel] = []
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames(pageSize: Int) {
        output?.willStartLoading()
        
        homeUseCase.getGames(pageSize: pageSize)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] games in
                    self?.games = games
                    self?.output?.didFinishLoading()
                    self?.output?.didGetGames(games)
                },
                onError: { [weak self] error in
                    self?.output?.didFinishLoading()
                    self?.output?.didFailGetGames(with: error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func showDetailGame(from viewController: UIViewController, gameId: Int) {
        router.navigateToDetail(from: viewController, gameId: gameId)
    }
}
