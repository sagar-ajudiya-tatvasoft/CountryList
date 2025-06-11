//
//  KFImageView.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    // MARK: - Variable
    let url: URL?
    
    var body: some View {
        KFImage(url)
            .resizable()
            .cancelOnDisappear(true)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    KFImageView(url: nil)
}
