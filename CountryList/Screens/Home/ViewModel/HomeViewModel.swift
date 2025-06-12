//
//  HomeViewModel.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation

@Observable
class HomeViewModel {
    
    // MARK: - Variable
    var searchText: String = ""
    var allCountries: [CountryResponse] = []
    var selectedCountries: [CountryResponse] = []
    var viewState: ViewState<[CountryResponse]> = .fetching
    var selectedCountry: CountryResponse? = nil
    private let locationManager = LocationManager()

    func loadInitialData() async {
        // Try loading from Core Data
        let local = CoreDataManager.shared.fetchCountries()
        
        // If internet is not available and no local data → show empty
        if Reachability.shared.connection == .none {
            if local.isEmpty {
                viewState = .failure(NetworkError.noInternetConnection)
                return
            } else {
                allCountries = local
                getSelectedCountries()
                return
            }
        }
        
        // If empty, Get from the API
        if local.isEmpty {
            await fetchCountries()
        } else {
            allCountries = local
        }
        getSelectedCountries()
        locationManager.onCountryDetected = { [weak self] country in
            guard let self else { return }
            autoSelectCountryIfNeeded(from: country)
        }
    }
    
    // Fetch Country
    private func fetchCountries() async {
        do {
            allCountries = try await APIClient.request(endPoint: .countries)
            CoreDataManager.shared.saveCountries(allCountries)
        } catch {
            viewState = .failure(error)
        }
    }
    
    // Select country from current location
     func autoSelectCountryIfNeeded(from name: String) {
        let selected = UserDefaultManager.getDataWith(type: [CountryResponse].self, key: .selectedCountries) ?? []
        guard selected.isEmpty else { return }

        guard let matchedCountry = allCountries.first(where: { $0.name?.lowercased() == name.lowercased() }) else {
            return
        }

        var selectedCountry = matchedCountry
        selectedCountry.isSelected = true
        CoreDataManager.shared.toggleCountrySelection(for: selectedCountry.id)
        UserDefaultManager.setDataWith([selectedCountry], key: .selectedCountries)
        getSelectedCountries()
    }

    // Get user's selected countries
    func getSelectedCountries() {
        selectedCountries = UserDefaultManager.getDataWith(type: [CountryResponse].self, key: .selectedCountries) ?? []
        viewState = .success(selectedCountries)
        
        if selectedCountries.isEmpty {
            viewState = .empty
        }
    }
    
    // Remove the selected country
    func removeSelectedCountry(country: CountryResponse) {
        selectedCountries.removeAll(where: { $0.id == country.id })
        UserDefaultManager.setDataWith(selectedCountries, key: .selectedCountries)
        CoreDataManager.shared.toggleCountrySelection(for: country.id)
        
        if selectedCountries.isEmpty {
            viewState = .empty
        }
    }
}
