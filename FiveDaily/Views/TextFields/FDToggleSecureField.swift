//
//  ToggleSecureField.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/1/24.
//

import SwiftUI

struct FDToggleSecureField: View {
    @FocusState var focus1: Bool
    @FocusState var focus2: Bool
    @State var showPassword: Bool = false

    var iconName: String
    var title: String
    @Binding var text: String
    var onChange: ((String) -> Void)? = nil
    var error: String? = nil

    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .trailing) {
                    FDTextField(iconName: iconName,
                                title: title,
                                text: $text,
                                autocapitalizationType: .never,
                                onChange: onChange,
                                error: error)
                        .opacity(showPassword ? 1 : 0)
                    FDSecureField(iconName: iconName,
                                  title: title,
                                  text: $text,
                                  onChange: onChange,
                                  error: error)
                        .opacity(showPassword ? 0 : 1)
                    Button(action: {
                        showPassword.toggle()
                        if showPassword { focus1 = true } else { focus2 = true }
                    }, label: {
                        Image(systemName: self.showPassword ?
                            "eye.slash.fill" : "eye.fill")
                            .padding(.bottom, ((error?.isEmpty) == nil) ? 20 : 40)
                            .padding(.trailing)
                            .foregroundColor(Color(.systemGray))
                    })
                }
            }
        }
    }
}

#Preview {
    @State var password = ""
    @State var errorMessage: String? = "Error on the textfield"

    return FDToggleSecureField(iconName: "lock", title: "Password", text: $password, error: nil)
}
