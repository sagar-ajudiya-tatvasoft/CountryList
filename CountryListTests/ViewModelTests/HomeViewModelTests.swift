//
//  HomeViewModelTests.swift
//  CountryListTests
//
//  Created by MACM06 on 12/06/25.
//

import XCTest
@testable import CountryList

final class HomeViewModelTests: XCTestCase {
    // MARK: - Variable
    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testEmptyInitialState() {
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertTrue(viewModel.allCountries.isEmpty)
        XCTAssertTrue(viewModel.selectedCountries.isEmpty)
        XCTAssertEqual(viewModel.viewState, .fetching)
    }

    func testGetSelectedCountries_WhenEmpty() {
        viewModel.getSelectedCountries()
        XCTAssertEqual(viewModel.selectedCountries, [])
        XCTAssertEqual(viewModel.viewState, .empty)
    }

    func testGetSelectedCountries_WhenSelectedExists() {
        UserDefaultManager.setDataWith([MockData.india], key: .selectedCountries)
        viewModel.getSelectedCountries()

        XCTAssertEqual(viewModel.selectedCountries, [MockData.india])
        XCTAssertEqual(viewModel.viewState.value, [MockData.india])
    }

    func testAutoSelectCountryIfNeeded_SelectsIfNoneSelected() {
        CoreDataManager.shared.saveCountries([MockData.japan])
        viewModel.allCountries = [MockData.japan]

        viewModel.autoSelectCountryIfNeeded(from: "Japan")

        let stored = UserDefaultManager.getDataWith(type: [CountryResponse].self, key: .selectedCountries)
        XCTAssertEqual(stored?.first?.name, "Japan")
        XCTAssertEqual(stored?.first?.isSelected, true)
    }

    func testRemoveSelectedCountry_RemovesAndUpdatesState() {
        viewModel.selectedCountries = [MockData.france]
        UserDefaultManager.setDataWith([MockData.france], key: .selectedCountries)

        viewModel.removeSelectedCountry(country: MockData.france)

        XCTAssertTrue(viewModel.selectedCountries.isEmpty)
        XCTAssertEqual(viewModel.viewState, .empty)
    }
}
