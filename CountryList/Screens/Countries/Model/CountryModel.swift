//
//  CountryModel.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

// MARK: - CountryResponse
struct CountryResponse: Codable, Identifiable {
    var id: String {
        name ?? UUID().uuidString
    }
    let name, capital: String?
    let flags: Flags?
    let currencies: [Currency]?
    var isSelected: Bool? = false
}

// MARK: - Currency
struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
}

// MARK: - CountryRequest
struct CountryRequest: Codable {
    var fields = "name,capital,currencies,flags"
}
