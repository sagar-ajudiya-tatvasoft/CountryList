//
//  MockData.swift
//  CountryListTests
//
//  Created by MACM06 on 12/06/25.
//

import Foundation
@testable import CountryList

enum MockData {
    static let india = CountryResponse(
        name: "India",
        capital: "New Delhi",
        flags: Flags(png: "https://flagcdn.com/in.png"),
        currencies: [Currency(code: "INR", name: "Rupee", symbol: "₹")],
        isSelected: true
    )

    static let japan = CountryResponse(
        name: "Japan",
        capital: "Tokyo",
        flags: Flags(png: "https://flagcdn.com/jp.png"),
        currencies: [Currency(code: "JPY", name: "Yen", symbol: "¥")],
        isSelected: false
    )

    static let france = CountryResponse(
        name: "France",
        capital: "Paris",
        flags: Flags(png: "https://flagcdn.com/fr.png"),
        currencies: [Currency(code: "EUR", name: "Euro", symbol: "€")],
        isSelected: true
    )
}
