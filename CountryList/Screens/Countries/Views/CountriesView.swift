//
//  CountriesView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI

struct CountriesView: View {
    
    // MARK: - Variable
    @State private var viewModel = CountriesViewModel()

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .fetching:
                LoadingView()
            case .success(_):
                mainView
            case .failure(_):
                mainView
            case .empty:
                EmptyDataView(text: String.noCountries)
            }
        }
        .task {
            viewModel.fetchCountries()
        }
        .padding(.horizontal)
        .background(.appRose15)
        .navigationDestination(item: $viewModel.selectedCountry) { country in
            CountryDetailsView(country: country)
                .navigationBarBackButtonHidden()
        }
    }
}

// MARK: - Views
extension CountriesView {

    private var mainView: some View {
        VStack {
            NavBarView()
            // Search
            SearchBarView(placeholder: String.searchCountries, searchText: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { _, newValue in
                    if newValue.hasPrefix(" ") {
                        viewModel.searchText = newValue.trimmingCharacters(in: .whitespaces)
                    }
                }
            // Country list
            CountryListView(countries: $viewModel.filteredCountries) { county in
                viewModel.toggleCountrySelection(for: county.id)
            } didTapRow: { country in
                viewModel.selectedCountry = country
            }
        }
    }
}

#Preview {
    CountriesView()
}
