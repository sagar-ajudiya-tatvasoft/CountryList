//
//  CountryModel.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

struct CountryResponse: Codable, Identifiable {
    var id: String {
        name ?? UUID().uuidString
    }
    let name, capital: String?
    let flags: Flags?
    let currencies: [Currency]?
    let independent: Bool?
}

struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

struct Flags: Codable {
    let svg: String?
    let png: String?
}

struct CountryRequest: Codable {
    var fields = "name,capital,currencies,flags"
}
