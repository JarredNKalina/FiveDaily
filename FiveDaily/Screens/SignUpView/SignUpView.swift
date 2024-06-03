//
//  SignUpView.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 5/31/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Welcome,")
                .font(.headline)
                .foregroundStyle(Color(.systemGray))
                .padding(.bottom, 30)

            FDTextField(iconName: "person",
                        title: "Full Name",
                        text: $authViewModel.fullName,
                        autocapitalizationType: .words)

            FDTextField(iconName: "envelope",
                        title: "Email",
                        text: $authViewModel.email,
                        autocapitalizationType: .never)

            FDToggleSecureField(iconName: "lock",
                                title: "Password",
                                text: $authViewModel.password,
                                onChange: { _ in
                                    authViewModel.setFirstPasswordError()
                                    // Do something with the new text here
                                },
                                error: authViewModel.firstPasswordError)

            FDToggleSecureField(iconName: "lock",
                                title: "Re-Password",
                                text: $authViewModel.rePassword)

            Button {
                Task {
                    await authViewModel.signup(email: authViewModel.email,
                                               password: authViewModel.password,
                                               fullName: authViewModel.fullName)
                }
            } label: { FDButton(title: "Sign up") }
                .padding(.bottom, 20)

            HStack {
                Text("Have an account?")
                NavigationLink(destination: LoginView()) {
                    FDClickableText(title: "Sign in")
                }
            }
        }.padding()

        if authViewModel.isLoading {
            ProgressView()
        }
        Text(authViewModel.errorMessage).foregroundStyle(.red)
    }
}

#Preview {
    @State var isSignedIn = false

    return SignUpView().environmentObject(AuthViewModel())
}
