//
//  ContentView.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var navigationViewModel: NavigationViewModel

    var body: some View {
        Group {
            switch authViewModel.authState {
            case .Initial:
                Text("Loading")
            case .Signin:
                HomeView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationViewModel)
            case .Signout:
                LoginView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationViewModel)
            }
        }
        .task {
            await authViewModel.isUserSignIn()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(NavigationViewModel())
}
