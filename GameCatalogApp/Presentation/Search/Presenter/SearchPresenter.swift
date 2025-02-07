//
//  SearchPresenter.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 07/02/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchPresenterDelegate: AnyObject {
    func willStartLoading()
    func didFinishLoading()
    func didFailGetGames(with error: Error)
}

class SearchPresenter {
    private let searchUseCase: SearchUseCase
    private let disposeBag = DisposeBag()
    weak var delegate: SearchPresenterDelegate?
    let router = SearchRouter()
    
    let gamesRelay = BehaviorRelay<[GameModel]>(value: [])
    var games: [GameModel] {
        return gamesRelay.value
    }
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func searchGames(query: String) {
        delegate?.willStartLoading()
        
        searchUseCase.searchGames(query: query)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] games in
                self?.gamesRelay.accept(games)
            } onError: { [weak self] error in
                self?.delegate?.didFailGetGames(with: error)
            } onCompleted: { [weak self] in
                self?.delegate?.didFinishLoading()
            }
            .disposed(by: disposeBag)
    }
    
    func showDetailGame(from viewController: UIViewController, gameId: Int) {
        router.navigateToDetail(from: viewController, gameId: gameId)
    }
    
}
