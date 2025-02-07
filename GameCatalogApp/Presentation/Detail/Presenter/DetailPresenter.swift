//
//  DetailPresenter.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import RxSwift

protocol DetailPresenterProtocolDelegate: AnyObject {
    func willStartLoading()
    func didFinishLoading()
    func didGetDetailGame(with game: GameModel)
    func didFailGetDetailGames(with error: Error)
    func didSuccessToggleFavoriteStatus(isFavorite: Bool)
    func didCheckIsFavorite(isFavorite: Bool)
}

class DetailPresenter {
    
    private let detailUseCase: DetailUseCase
    private let disposeBag = DisposeBag()
    weak var delegate: DetailPresenterProtocolDelegate?
    private(set) var game: GameModel?
    private(set) var isLoading = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getGameDetail(id: Int) {
        delegate?.willStartLoading()
        detailUseCase.getGameDetail(gameId: id)
            .subscribe { [weak self] game in
                self?.game = game
                self?.delegate?.didGetDetailGame(with: game)
            } onError: { [weak self] error in
                self?.delegate?.didFailGetDetailGames(with: error)
            } onCompleted: { [weak self] in
                self?.delegate?.didFinishLoading()
            }
            .disposed(by: disposeBag)
    }
    
    func checkIsFavorite(gameId: Int) {
        detailUseCase.isAlreadyFavorite(gameId: gameId)
            .subscribe { [weak self] isFavorite in
                self?.delegate?.didCheckIsFavorite(isFavorite: isFavorite)
            }
            .disposed(by: disposeBag)
    }
    
    func toggleFavoriteStatus(game: GameModel) {
        detailUseCase.isAlreadyFavorite(gameId: game.id)
            .subscribe { [weak self] isFavorite in
                guard let self = self else { return }
                if isFavorite {
                    self.detailUseCase.removeFavoriteGame(gameId: game.id)
                        .subscribe(onCompleted: {
                            self.delegate?.didSuccessToggleFavoriteStatus(isFavorite: isFavorite)
                        })
                        .disposed(by: self.disposeBag)
                } else {
                    self.detailUseCase.saveFavoriteGame(game: game)
                        .subscribe(onCompleted: {
                            self.delegate?.didSuccessToggleFavoriteStatus(isFavorite: isFavorite)
                        })
                        .disposed(by: self.disposeBag)
                }
            }
            .disposed(by: disposeBag)
    }
    
}
