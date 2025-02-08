//
//  UseCase.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation
import RxSwift

public protocol UseCaseProtocol {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
