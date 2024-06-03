//
//  FDClickableText.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 5/31/24.
//

import SwiftUI

struct FDClickableText: View {
    let title: LocalizedStringKey

    var body: some View {
        Text(title)
            .foregroundColor(.accent)
    }
}

#Preview {
    FDClickableText(title: "Example Text")
}
