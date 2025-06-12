//
//  NavBarView.swift
//  CountryList
//
//  Created by MACM06 on 12/06/25.
//

import SwiftUI

struct NavBarView: View {
    // MARK: - Variable
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            // Back
            Button {
                dismiss()
            } label: {
                Image(.icBack)
            }
            Spacer()
            // Done
            Button {
                dismiss()
            } label: {
                Text(String.done)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.appRose)
            }
        }
    }
}

#Preview {
    NavBarView()
}
