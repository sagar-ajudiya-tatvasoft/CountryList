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
        guard let url = URL(string: "https://restcountries.com/v2/" + path) else {
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
//        urlRequest.logCURL(pretty: true)
        return urlRequest
    }
}

extension URLRequest {
    @discardableResult
    func logCURL(pretty: Bool = false) -> String {
        print("============= cURL ============= \n")
        
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        print(cURL)
        return cURL
    }
}

extension String {
    
    func asUrl() throws -> URL {
        guard let url = URL(string: self) else {
            throw NetworkError.invalidUrl
        }
        return url
    }
}

extension Encodable {
    func toDictionary() throws -> [String:Any] {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            if let jsonData = try JSONSerialization.jsonObject(with: data) as? [String : Any]{
                return jsonData
            }
        } catch {
            throw NetworkError.encodingError
        }
        return [:]
    }
}

