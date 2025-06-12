//
//  Endpoint.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var params: Requestparams { get }
}

extension Endpoint {
    
    func urlRequest() throws -> URLRequest {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String else {
            throw NetworkError.invalidUrl
        }
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
                
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        switch params {
        case .query(let request):
            let params = try request?.toDictionary() ?? [:]
            let queryItems = params.compactMap({URLQueryItem(name: $0.key, value: "\($0.value)")})
            
            var urlComponent = URLComponents(string: url.absoluteString)
            urlComponent?.queryItems = queryItems
            urlRequest.url = urlComponent?.url
            
        case .body(let request):
            let params = try request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        return urlRequest
    }
}
