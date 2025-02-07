//
//  FavoriteInteractor.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteGames() -> Observable<[GameModel]>
}

class FavoriteInteractor: NSObject {
    
    private let repository: GamesRepositoryProtocol
    
    required init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
}

extension FavoriteInteractor: FavoriteUseCase {
    func getFavoriteGames() -> Observable<[GameModel]> {
        return repository.getAllGames()
    }
}
