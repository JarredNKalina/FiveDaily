//
//  FDButton.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 5/29/24.
//

import SwiftUI

struct FDButton: View {
    let title: LocalizedStringKey
    var width: CGFloat?

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: width, height: 50)
            .foregroundColor(.white)
            .background(.accent).cornerRadius(10)
    }
}

#Preview {
    FDButton(title: "Test Title")
}
