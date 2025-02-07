//
//  DetailInteractor.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    // Remote
    func getGameDetail(gameId: Int) -> Observable<GameModel>
    
    // Local
    func isAlreadyFavorite(gameId: Int) -> Observable<Bool>
    func saveFavoriteGame(game: GameModel) -> Observable<Void>
    func removeFavoriteGame(gameId: Int) -> Observable<Void>
}

class DetailInteractor: NSObject {
    private let repository: GamesRepositoryProtocol
    
    required init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
}

extension DetailInteractor: DetailUseCase {
    func getGameDetail(gameId: Int) -> RxSwift.Observable<GameModel> {
        return repository.getGameDetail(id: gameId)
    }
    
    func isAlreadyFavorite(gameId: Int) -> RxSwift.Observable<Bool> {
        return repository.isAlreadyFavorite(id: gameId)
    }
    
    func saveFavoriteGame(game: GameModel) -> RxSwift.Observable<Void> {
        return repository.saveGame(game: game)
    }
    
    func removeFavoriteGame(gameId: Int) -> RxSwift.Observable<Void> {
        return repository.removeGame(gameId: gameId)
    }
    
}
