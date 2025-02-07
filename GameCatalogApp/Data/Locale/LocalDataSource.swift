//
//  LocalDataSource.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 28/01/25.
//

import Foundation
import CoreData
import RxSwift

protocol LocalDataSourceProtocol: AnyObject {
    func getAllGames() -> Observable<[GameEntity]>
    func saveGame(from games: GameModel) -> Observable<Void>
    func removeGame(from gameId: Int) -> Observable<Void>
    func isAlreadyFavorite(id: Int) -> Observable<Bool>
}

final class LocalDataSource: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameCatalog")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Failed to load store: \(error!)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    static let sharedInstance: LocalDataSource = LocalDataSource()
}

extension LocalDataSource: LocalDataSourceProtocol {
    func getAllGames() -> RxSwift.Observable<[GameEntity]> {
        return Observable.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
                do {
                    let result = try taskContext.fetch(fetchRequest)
                    guard let newResult = result as? [GameEntity] else {
                        observer.onNext([])
                        observer.onCompleted()
                        return
                    }
                    observer.onNext(newResult)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func saveGame(from game: GameModel) -> RxSwift.Observable<Void> {
        return Observable.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let gameEntity = NSEntityDescription.entity(forEntityName: "GameEntity", in: taskContext)
                let newGame = NSManagedObject(entity: gameEntity!, insertInto: taskContext)
                
                newGame.setValuesForKeys([
                    "id": game.id,
                    "name": game.name ?? "",
                    "released": game.released ?? "",
                    "rating": game.rating ?? 0.0,
                    "backgroundImage": game.backgroundImage ?? "",
                    "descriptionGame": game.description ?? "",
                    "alternativeNames": game.alternativeNames ?? [],
                    "genres": game.genres?.map { $0.name } ?? [],
                    "publishers": game.publishers?.map { $0.name } ?? []
                ])
                
                do {
                    try taskContext.save()
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func removeGame(from gameId: Int) -> RxSwift.Observable<Void> {
        return Observable.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == %d", gameId)
                
                do {
                    let result = try taskContext.fetch(fetchRequest)
                    for object in result {
                        taskContext.delete(object)
                    }
                    
                    try taskContext.save()
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func isAlreadyFavorite(id: Int) -> RxSwift.Observable<Bool> {
        return Observable.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == %d", id)
                
                do {
                    let result = try taskContext.fetch(fetchRequest)
                    observer.onNext(!result.isEmpty)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
}
