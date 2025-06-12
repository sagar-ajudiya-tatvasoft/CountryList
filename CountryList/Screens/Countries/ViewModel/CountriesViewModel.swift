//
//  CountriesViewModel.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

@Observable
class CountriesViewModel {
    
    // MARK: - Variable
    var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    private var countries = [CountryResponse]()
    var filteredCountries = [CountryResponse]()
    var viewState: ViewState<[CountryResponse]> = .fetching
    
    // Fetch Country
    func fetchCountries() {
        countries = fetchCountriesFromCoreData()
        filteredCountries = countries
        viewState = countries.isEmpty ? .empty : .success(countries)
    }
    
    // Filter Country as per the Search
    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }
    
    // Save to CoreData
    private func saveCountriesToCoreData(countries: [CountryResponse]) {
        CoreDataManager.shared.saveCountries(countries)
    }
    
    // Get From CoreData
    private func fetchCountriesFromCoreData() -> [CountryResponse] {
        return CoreDataManager.shared.fetchCountries()
    }

    // Manage the country selection
    func toggleCountrySelection(for id: String) {
        guard let index = filteredCountries.firstIndex(where: { $0.id == id }) else { return }

        var selectedCountries = UserDefaultManager.getDataWith(type: [CountryResponse].self, key: .selectedCountries) ?? []
        let isCurrentlySelected = filteredCountries[index].isSelected == true

        if isCurrentlySelected {
            filteredCountries[index].isSelected = false
            selectedCountries.removeAll { $0.id == id }
        } else {
            if selectedCountries.count >= 5 {
                viewState = .failure(AppError.maxCountriesReached)
                return
            }
            filteredCountries[index].isSelected = true
            selectedCountries.append(filteredCountries[index])
        }
        CoreDataManager.shared.toggleCountrySelection(for: id)
        UserDefaultManager.setDataWith(selectedCountries, key: .selectedCountries)
    }

    // Select country from current location
    func autoSelectCountry(by name: String) {
        guard let index = filteredCountries.firstIndex(where: { $0.name?.lowercased() == name.lowercased() }) else { return }
        
        filteredCountries[index].isSelected = true
        CoreDataManager.shared.toggleCountrySelection(for: filteredCountries[index].id)

        let selectedCountries = filteredCountries.filter { $0.isSelected == true }
        UserDefaultManager.setDataWith(selectedCountries, key: .selectedCountries)
    }
}
