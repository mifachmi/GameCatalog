//
//  SearchInteractor.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 07/02/25.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func searchGames(query: String) -> Observable<[GameModel]>
}

class SearchInteractor: NSObject {
    
    private let repository: GamesRepositoryProtocol
    
    init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
}

extension SearchInteractor: SearchUseCase {
    func searchGames(query: String) -> Observable<[GameModel]> {
        return repository.searchGames(query: query)
    }
}
