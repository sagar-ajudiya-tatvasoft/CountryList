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
    
    init(name: String? = nil, capital: String? = nil, flags: Flags? = nil, currencies: [Currency]? = nil, isSelected: Bool? = nil) {
        self.name = name
        self.capital = capital
        self.flags = flags
        self.currencies = currencies
        self.isSelected = isSelected
    }
}

// MARK: - Currency
struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
    
    init(code: String?, name: String?, symbol: String?) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
    
    init(png: String?) {
        self.png = png
    }
}

// MARK: - CountryRequest
struct CountryRequest: Codable {
    var fields = "name,capital,currencies,flags"
}

extension CountryResponse: Equatable {
    static func == (lhs: CountryResponse, rhs: CountryResponse) -> Bool {
        return lhs.name == rhs.name &&
               lhs.capital == rhs.capital &&
               lhs.flags == rhs.flags &&
               lhs.currencies == rhs.currencies &&
               lhs.isSelected == rhs.isSelected
    }
}

extension Flags: Equatable {
    static func == (lhs: Flags, rhs: Flags) -> Bool {
        return lhs.png == rhs.png
    }
}

extension Currency: Equatable {
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code &&
               lhs.name == rhs.name &&
               lhs.symbol == rhs.symbol
    }
}
