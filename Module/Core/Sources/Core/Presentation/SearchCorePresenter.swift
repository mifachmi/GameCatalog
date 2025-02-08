//
//  SearchCorePresenter.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift
import RxCocoa

public class SearchCorePresenter<
    Response,
    Interactor: UseCaseProtocol
> where Interactor.Request == String,
        Interactor.Response == Response {
    
    private let _interactor: Interactor
    private let _disposeBag = DisposeBag()
    
    public var searchResult: Observable<Response> {
        return _searchResult.asObservable()
    }
    
    private let _searchResult: BehaviorRelay<Response>
    public weak var delegate: CorePresenterDelegate?
    
    public init(interactor: Interactor, initialResult: Response) {
        _interactor = interactor
        _searchResult = BehaviorRelay<Response>(value: initialResult)
    }
    
    public func search(query: String) {
        delegate?.willStartLoading()
        _interactor.execute(request: query)
            .subscribe(onNext: { result in
                self._searchResult.accept(result)
                self.delegate?.didFinishLoading()
            }, onError: { error in
                self.delegate?.didFail(with: error)
            })
            .disposed(by: _disposeBag)
    }
}
