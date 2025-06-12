//
//  ViewState.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum ViewState<V> {
    case fetching
    case success(V)
    case failure(Error)
    case empty
    
    var value: V? {
        if case .success(let v) = self {
            return v
        }
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}

extension ViewState: Equatable where V: Equatable {
    static func == (lhs: ViewState<V>, rhs: ViewState<V>) -> Bool {
        switch (lhs, rhs) {
        case (.fetching, .fetching):
            return true
        case (.empty, .empty):
            return true
        case (.success(let a), .success(let b)):
            return a == b
        case (.failure(let e1), .failure(let e2)):
            return e1.localizedDescription == e2.localizedDescription
        default:
            return false
        }
    }
}
