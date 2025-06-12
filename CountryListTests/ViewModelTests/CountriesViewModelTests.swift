//
//  CountriesViewModelTests.swift
//  CountryListTests
//
//  Created by MACM06 on 12/06/25.
//

import XCTest
@testable import CountryList

final class CountriesViewModelTests: XCTestCase {
    // MARK: - Variable
    var viewModel: CountriesViewModel!
    var mockCountries: [CountryResponse]!

    override func setUp() {
        super.setUp()
        viewModel = CountriesViewModel()
        
        mockCountries = [
            CountryResponse(name: "India", capital: "New Delhi", flags: Flags(png: nil), currencies: nil, isSelected: false),
            CountryResponse(name: "Canada", capital: "Ottawa", flags: Flags(png: nil), currencies: nil, isSelected: false),
            CountryResponse(name: "France", capital: "Paris", flags: Flags(png: nil), currencies: nil, isSelected: false)
        ]

        // Save to CoreData directly for test
        CoreDataManager.shared.saveCountries(mockCountries)
    }

    override func tearDown() {
        viewModel = nil
        mockCountries = nil
        super.tearDown()
    }

    func testFetchCountries() {
        viewModel.fetchCountries()

        XCTAssertFalse(viewModel.filteredCountries.isEmpty)
        XCTAssertEqual(viewModel.filteredCountries.count, 3)
        XCTAssertEqual(viewModel.viewState, .success(mockCountries))
    }

    func testSearchFiltering() {
        viewModel.fetchCountries()
        viewModel.searchText = "can"
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.name, "Canada")
    }

    func testToggleCountrySelection() {
        viewModel.fetchCountries()
        let countryId = mockCountries[0].id
        
        viewModel.toggleCountrySelection(for: countryId)
        
        let selected = UserDefaultManager.getDataWith(type: [CountryResponse].self, key: .selectedCountries)
        XCTAssertEqual(selected?.first?.id, countryId)
        XCTAssertTrue(viewModel.filteredCountries.first?.isSelected ?? false)
    }
}
