//
//  Interactor.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift

public struct Interactor<Request, Response, R: CoreRepositoryProtocol>: UseCaseProtocol
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func execute(request: Request?) -> Observable<Response> {
        return _repository.execute(request: request)
    }
}
