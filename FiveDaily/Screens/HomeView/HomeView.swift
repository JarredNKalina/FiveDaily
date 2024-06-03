//
//  HomeView.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/1/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Button {
            Task {
                await authViewModel.signoutUser()
            }
        } label: { FDButton(title: "Sign out") }
    }
}

#Preview {
    HomeView().environmentObject(AuthViewModel())
}
