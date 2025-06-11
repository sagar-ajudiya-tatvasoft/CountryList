//
//  EndPointType.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum EndPointType {
    case countries
}

extension EndPointType: Endpoint {

    var path: String {
        switch self {
        case .countries: return "all"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .countries:
            return .get
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .countries:
            return [
                HttpHeaderKeys.contentType.rawValue : HttpHeaderValues.json.rawValue,
                HttpHeaderKeys.acceptType.rawValue : HttpHeaderValues.json.rawValue
            ]
        }
    }
     
    var params: Requestparams {
        switch self {
        case .countries:
            return .query(CountryRequest())
        }
    }
}
