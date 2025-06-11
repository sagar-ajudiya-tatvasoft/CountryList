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
