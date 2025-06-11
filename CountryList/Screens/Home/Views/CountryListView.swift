//
//  CountryListView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI

struct CountryListView: View {
    // MARK: - Variable
    @Binding var countries: [CountryResponse]
    let didSelectCountry: (CountryResponse) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($countries) { country in
                    CountryRowView(country: country) {
                        didSelectCountry(country.wrappedValue)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CountryListView(countries: .constant([])) { _ in }
}
