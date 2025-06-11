//
//  EmptyDataView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI

struct EmptyDataView: View {
    // MARK: - Variable
    let text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.appDarkGrey)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyDataView(text: "")
}
