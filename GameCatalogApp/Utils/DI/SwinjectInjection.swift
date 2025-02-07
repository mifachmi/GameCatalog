//
//  SwinjectInjection.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 07/02/25.
//

import Foundation
import Swinject

final class SwinjectInjection {
    static let shared = SwinjectInjection()
    
    let container: Container
    
    private init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(GamesRepositoryProtocol.self) { _ in
            let localDataSource = LocalDataSource.sharedInstance
            let remoteDataSource = RemoteDataSource.sharedInstance
            return GamesRepository.sharedInstance(localDataSource, remoteDataSource)
        }.inObjectScope(.container)
        
        container.register(HomeUseCase.self) { resolver in
            let repository = resolver.resolve(GamesRepositoryProtocol.self)!
            return HomeInteractor(repository: repository)
        }
        
        container.register(DetailUseCase.self) { resolver in
            let repository = resolver.resolve(GamesRepositoryProtocol.self)!
            return DetailInteractor(repository: repository)
        }
        
        container.register(FavoriteUseCase.self) { resolver in
            let repository = resolver.resolve(GamesRepositoryProtocol.self)!
            return FavoriteInteractor(repository: repository)
        }
        
        container.register(SearchUseCase.self) { resolver in
            let repository = resolver.resolve(GamesRepositoryProtocol.self)!
            return SearchInteractor(repository: repository)
        }
    }
}
