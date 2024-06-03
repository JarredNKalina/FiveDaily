//
//  NavigationViewModel.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/2/24.
//

import Combine
import Foundation
import SwiftUI

enum AuthRoute: String, Hashable {
    case Login
    case Signup
    case Home
}

class NavigationViewModel: ObservableObject {
    @Published var authPath = NavigationPath()

    func navigate(authRoute: AuthRoute) {
        authPath.append(authRoute)
    }

    func popToRoot() {
        authPath.removeLast(authPath.count)
    }

    func pop() {
        authPath.removeLast()
    }
}
