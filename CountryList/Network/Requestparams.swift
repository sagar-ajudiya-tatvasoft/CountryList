//
//  Requestparams.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum Requestparams {
    case body(_ request: Encodable?)
    case query(_ request: Encodable?)
}
