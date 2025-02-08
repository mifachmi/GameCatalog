//
//  LocalCoreDataSource.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift

public protocol LocalCoreDataSourceProtocol {
    associatedtype Request
    associatedtype Response
    
    func getAllGames() -> Observable<[Response]>
    func saveGame(game: Request) -> Observable<Void>
    func removeGame(gameId: Int) -> Observable<Void>
    func isAlreadyFavorite(id: Int) -> Observable<Bool>
}
