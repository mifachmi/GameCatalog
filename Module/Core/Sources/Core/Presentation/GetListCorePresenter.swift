//
//  GetListCorePresenter.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift
import RxCocoa

public class GetListCorePresenter<
    Request,
    Response,
    Interactor: UseCaseProtocol
> where Interactor.Request == Request,
        Interactor.Response == [Response] {
    
    private let _interactor: Interactor
    private let _disposeBag = DisposeBag()
    
    private let _resultsRelay: BehaviorRelay<[Response]> = BehaviorRelay<[Response]>(value: [])
    
    public var results: Observable<[Response]> {
        return _resultsRelay.asObservable()
    }
    
    public weak var delegate: CorePresenterDelegate?
    
    public init(interactor: Interactor) {
        _interactor = interactor
    }
    
    public func execute(request: Request?) {
        delegate?.willStartLoading()
        _interactor.execute(request: request)
            .subscribe(onNext: { [weak self] responseList in
                self?._resultsRelay.accept(responseList)
                self?.delegate?.didFinishLoading()
            }, onError: { [weak self] error in
                self?.delegate?.didFail(with: error)
            })
            .disposed(by: _disposeBag)
    }
    
}
