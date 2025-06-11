//
//  AppError.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

enum AppError: String, Error {
    case maxCountriesReached = "You can only select up to 5 countries. Please unselect one to add another."
}
