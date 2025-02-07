//
//  GamesRepository.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import RxSwift

protocol GamesRepositoryProtocol {
    // Local
    func getAllGames() -> Observable<[GameModel]>
    func saveGame(game: GameModel) -> Observable<Void>
    func removeGame(gameId: Int) -> Observable<Void>
    func isAlreadyFavorite(id: Int) -> Observable<Bool>
    
    // Remote
    func getGames(pageSize: Int) -> Observable<[GameModel]>
    func getGameDetail(id: Int) -> Observable<GameModel>
    func searchGames(query: String) -> Observable<[GameModel]>
}

final class GamesRepository: NSObject {
    typealias GamesInstance = (LocalDataSource, RemoteDataSource) -> GamesRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: GamesInstance = { localRepo, remoteRepo in
        return GamesRepository(local: localRepo, remote: remoteRepo)
    }
    
}

extension GamesRepository: GamesRepositoryProtocol {
    func getAllGames() -> RxSwift.Observable<[GameModel]> {
        return local.getAllGames()
            .map { gameModel in
                return ObjectMapper.mapGameEntityToDomain(input: gameModel)
            }
    }
    
    func saveGame(game: GameModel) -> RxSwift.Observable<Void> {
        return local.saveGame(from: game)
    }
    
    func removeGame(gameId: Int) -> RxSwift.Observable<Void> {
        return local.removeGame(from: gameId)
    }
    
    func isAlreadyFavorite(id: Int) -> RxSwift.Observable<Bool> {
        return local.isAlreadyFavorite(id: id)
    }
    
    func getGames(pageSize: Int) -> RxSwift.Observable<[GameModel]> {
        return remote.getGames(pageSize: pageSize)
            .flatMap { gameResponse in
                let games = ObjectMapper.mapGameResponseToDomain(input: gameResponse)
                return Observable.just(games)
            }
    }
    
    func getGameDetail(id: Int) -> RxSwift.Observable<GameModel> {
        return remote.getDetailGame(id: id)
            .map { game in
                return ObjectMapper.mapGameResponseToDomain(input: game)
            }
    }
    
    func searchGames(query: String) -> RxSwift.Observable<[GameModel]> {
        print(query)
        return remote.searchGames(query: query)
            .flatMap { gameResponse in
                let games = ObjectMapper.mapGameResponseToDomain(input: gameResponse)
                return Observable.just(games)
            }
    }
    
}
