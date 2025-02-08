//
//  Mapper.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation

public protocol MapperProtocol {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(input response: [Response]) -> [Entity]
    func transformEntityToDomain(input entity: [Entity]) -> [Domain]
    func transformResponseToDomain(input response: Response) -> Domain
    func transformResponseToDoamin(input response: [Response]) -> [Domain]
}
