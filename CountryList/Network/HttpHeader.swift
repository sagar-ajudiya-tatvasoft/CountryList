//
//  HttpHeader.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum HttpHeaderKeys: String {
    case authentication = "Authorization"
    case acceptType = "accept"
    case contentType = "Content-Type"
}

enum HttpHeaderValues: String {
    case json = "Application/json"
}
