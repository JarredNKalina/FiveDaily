//
//  PasswordRequirementsView.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/3/24.
//

import SwiftUI

struct PasswordRequirement {
    let text: String
    var isMet: Bool
}

struct PasswordRequirementsView: View {
    let requirements: [PasswordRequirement]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(requirements, id: \.text) { requirement in
                HStack {
                    Image(systemName: requirement.isMet ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(requirement.isMet ? .green : .red)
                    Text(requirement.text)
                        .foregroundColor(requirement.isMet ? .green : .red)
                }
            }
        }
    }
}

#Preview {
    PasswordRequirementsView(requirements: [
        PasswordRequirement(text: "At least 8 characters", isMet: true),
        PasswordRequirement(text: "At least 1 uppercase letter", isMet: false),
        PasswordRequirement(text: "At least 1 lowercase letter", isMet: true),
        PasswordRequirement(text: "At least 1 digit", isMet: false),
        PasswordRequirement(text: "At least 1 special character", isMet: true)
    ])
}
