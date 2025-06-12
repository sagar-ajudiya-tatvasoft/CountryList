//
//  CountryRowView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI

struct CountryRowView: View {
    // MARK: - Variable
    @Binding var country: CountryResponse
    let didSelectCountry: () -> Void
    let didTapRow: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Flag Image
            KFImageView(url: URL(string: country.flags?.png ?? ""))
                .frame(width: 60, height: 60)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                // Name
                Text(country.name ?? "N/A")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.appBlack)
                // Capital
                Text(country.capital ?? "N/A")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.appDarkGrey)
                // Currency
                Text(country.currencies?.first?.name ?? "N/A")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.appDarkGrey)
            }

            Spacer()

            // Image Icon for select and unselect
            Button {
                withAnimation {
                    didSelectCountry()
                }
            } label: {
                Image(country.isSelected == true ? .icSquareCheck : .icSquare)
            }
        }
        .padding(12)
        .background(.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            didTapRow()
        }
    }
}
