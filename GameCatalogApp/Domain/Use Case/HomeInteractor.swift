//
//  HomeInteractor.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getGames(pageSize: Int) -> Observable<[GameModel]>
}

class HomeInteractor: NSObject {
    
    private let repository: GamesRepositoryProtocol
    
    init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeUseCase {
    func getGames(pageSize: Int) -> RxSwift.Observable<[GameModel]> {
        return repository.getGames(pageSize: pageSize)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
}
