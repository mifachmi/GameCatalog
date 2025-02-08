//
//  GetSingleCorePresenter.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift
import RxCocoa

public class GetSingleCorePresenter<
    Request,
    Response,
    Interactor: UseCaseProtocol
> where Interactor.Request == Request,
        Interactor.Response == Response {
    
    private let _interactor: Interactor
    private let _disposeBag = DisposeBag()
    
    private let _responseRelay: BehaviorRelay<Response?> = BehaviorRelay<Response?>(value: nil)
    
    public var response: Observable<Response?> {
        return _responseRelay.asObservable()
    }
    
    public weak var delegate: CorePresenterDelegate?
    
    public init(interactor: Interactor) {
        _interactor = interactor
    }
    
    public func execute(request: Request?) {
        delegate?.willStartLoading()
        _interactor.execute(request: request)
            .subscribe(onNext: { [weak self] response in
                self?._responseRelay.accept(response)
                self?.delegate?.didSucceedSingle(with: response)
                self?.delegate?.didFinishLoading()
            }, onError: { [weak self] error in
                self?.delegate?.didFail(with: error)
            })
            .disposed(by: _disposeBag)
    }
    
}
