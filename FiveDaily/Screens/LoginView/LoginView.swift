//
//  LoginView.swift
//  FiveDaily
//  Created by Jarred Kalina on 5/29/24.
//
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false

    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel

    var body: some View {
        NavigationStack(path: $navigationVM.authPath) {
            VStack {
                Spacer()
                Image("FiveDailyLogo").resizable().scaledToFit().padding(.bottom)

                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Welcome Back,")
                    .font(.headline)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.bottom, 30)

                FDTextField(iconName: "envelope",
                            title: "Email", text: $authViewModel.email,
                            autocapitalizationType: .never)
                FDToggleSecureField(iconName: "lock", title: "Password", text: $authViewModel.password)
                    .padding(.bottom, 20)

                Button {
                    Task {
                        await authViewModel.signIn(email: authViewModel.email, password: authViewModel.password)
                    }
                } label: { FDButton(title: "Login") }
                    .padding(.bottom, 20)

                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView()) {
                        FDClickableText(title: "Sign up")
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
    }
}

struct ActionButton: View {
    let signupButton = Color(red: 103.0/255.0, green: 104.0/255.0, blue: 255.0/255.0)

    let text: String

    var body: some View {
        Text(text)
            .accentColor(.white)
            .frame(minWidth: 0, maxWidth: 300)
            .frame(width: 200)
            .padding()
            .background(signupButton)
            .cornerRadius(10)
            .padding()
    }
}
