//
//  CorePresenterDelegate.swift
//  Core
//
//  Created by Fachmi Dimas Ardhana on 08/02/25.
//

import Foundation

public protocol CorePresenterDelegate: AnyObject {
    func willStartLoading()
    func didFinishLoading()
    func didSucceedList(with result: [Response])
    func didSucceedSingle(with result: Response)
    func didFail(with error: Error)
    
    // MARK: - for favorite feature
}
