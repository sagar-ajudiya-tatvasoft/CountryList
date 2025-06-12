//
//  CountryDetailsView.swift
//  CountryList
//
//  Created by MACM06 on 12/06/25.
//

import SwiftUI

import SwiftUI

struct CountryDetailsView: View {
    let country: CountryResponse
    
    var body: some View {
        ScrollView {
            // NavBar
            NavBarView(isShowRightIcon: false)
                .padding(.horizontal)
            
            VStack(spacing: 24) {
                // Flag
                KFImageView(url: URL(string: country.flags?.png ?? ""))
                    .frame(width: 140, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Country Info
                VStack(spacing: 12) {
                    Text(country.name ?? "N/A")
                        .font(.title2.bold())
                        .foregroundStyle(.appBlack)
                    
                    Divider()
                    // Capital
                    HStack {
                        Text(String.capital)
                            .fontWeight(.semibold)
                            .foregroundStyle(.appBlack)
                        Spacer()
                        Text(country.capital ?? "N/A")
                            .foregroundStyle(.appDarkGrey)
                    }
                    // Currency
                    HStack {
                        Text(String.currency)
                            .fontWeight(.semibold)
                            .foregroundStyle(.appBlack)
                        Spacer()
                        Text(country.currencies?.first?.name ?? "N/A")
                            .foregroundStyle(.appDarkGrey)
                    }
                }
                .padding()
                .background(.appWhite)
                .cornerRadius(16)
                .padding(.horizontal)
            }
            .padding(.top, 40)
        }
        .background(.appRose15)
    }
}

#Preview {
    CountryDetailsView(country: CountryResponse())
}
