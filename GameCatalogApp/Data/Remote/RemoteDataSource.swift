//
//  RemoteDataSource.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    func getGames(pageSize: Int) -> Observable<[GameResponse]>
    func getDetailGame(id: Int) -> Observable<GameResponse>
    func searchGames(query: String) -> Observable<[GameResponse]>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames(pageSize: Int) -> RxSwift.Observable<[GameResponse]> {
        return RxSwift.Observable.create { observer in
            let request = AF.request(GameEndpoint.getGames(pageSize: pageSize))
                .validate()
                .responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results)
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                    observer.onCompleted()
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getDetailGame(id: Int) -> RxSwift.Observable<GameResponse> {
        return RxSwift.Observable.create { observer in
            let request = AF.request(GameEndpoint.getGameDetail(id: id))
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                    observer.onCompleted()
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func searchGames(query: String) -> RxSwift.Observable<[GameResponse]> {
        return RxSwift.Observable.create { observer in
            let request = AF.request(GameEndpoint.searchGames(query: query))
                .validate()
                .responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results)
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                    observer.onCompleted()
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
