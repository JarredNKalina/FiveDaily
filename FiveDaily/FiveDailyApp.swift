//
//  FiveDailyApp.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 5/29/24.
//

import SwiftUI

@main
struct FiveDailyApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var navigationVM = NavigationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(navigationVM)
        }
    }
}
