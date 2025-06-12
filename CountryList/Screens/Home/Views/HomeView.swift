//
//  HomeView.swift
//  CountryList
//
//  Created by MACM06 on 10/06/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Variable
    @State private var viewModel = HomeViewModel()
    @State private var showCountryList = false
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .fetching:
                    LoadingView()
                case .success(_):
                    buttonSelectCountry
                    countryList
                case .failure(let error):
                    EmptyDataView(text: error.localizedDescription)
                case .empty:
                    buttonSelectCountry
                    EmptyDataView(text: String.noselectCountries)
                }
            }
            .padding()
            .background(.appRose15)
            .task {
                await viewModel.loadInitialData()
            }
            .navigationDestination(isPresented: $showCountryList) {
                CountriesView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(item: $viewModel.selectedCountry) { country in
                CountryDetailsView(country: country)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

// MARK: - Views
extension HomeView {
    
    // Selected country view
    private var countryList: some View {
        CountryListView(countries: $viewModel.selectedCountries) { country in
            viewModel.removeSelectedCountry(country: country)
        } didTapRow: { country in
            viewModel.selectedCountry = country
        }
    }
    
    // Select Country Button
    private var buttonSelectCountry: some View {
        SearchBarView(placeholder: String.selectCountries, searchText: $viewModel.searchText) {
            showCountryList = true
        }
    }
}

#Preview {
    HomeView()
}
