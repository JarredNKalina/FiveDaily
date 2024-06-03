//
//  FDTextField.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 5/31/24.
//

import SwiftUI

struct FDTextField: View {
    var iconName: String
    var title: String
    @Binding var text: String
    var autocapitalizationType: TextInputAutocapitalization
    var onChange: ((String) -> Void)? = nil
    var error: String? = nil

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName).padding(.leading, 10).foregroundColor(Color(.systemGray))

                TextField(title, text: $text)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(autocapitalizationType)
                    .onChange(of: text) {
                        onChange?(text)
                    }
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray), lineWidth: 1))
            .background(Color(.secondarySystemBackground))

            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .padding([.horizontal], 0)
            }

        }.padding(.bottom, 20)
    }
}

#Preview {
    @State var email = ""

    return FDTextField(iconName: "envelope", title: "Email", text: $email, autocapitalizationType: .never,
                       error: "error")
}
