//
//  SearchBarView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI

struct SearchBarView: View {
    // MARK: - Variable
    let placeholder: String
    @Binding var searchText: String
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            // Left Icon
            Image(.icSearch)
                .tint(.appRose)
            // TextField
            TextField(
                placeholder,
                text: $searchText,
                prompt: Text(placeholder)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.appDarkGrey)
            )
            .tint(.appDarkGrey)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .submitLabel(.done)
            .allowsHitTesting(onTap == nil)
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.appBlack, lineWidth: 0.5)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    SearchBarView(placeholder: "", searchText: .constant(""))
}
