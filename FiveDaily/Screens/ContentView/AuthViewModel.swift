//
//  AuthViewModel.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/2/24.
//

import Combine
import Foundation
import Supabase

enum AuthState: Hashable {
    case Initial
    case Signin
    case Signout
}

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    @Published var fullName: String = ""
    @Published var errorMessage: String = ""
    var cancellable = Set<AnyCancellable>()
    @Published var authState: AuthState = .Initial
    private var supabaseAuth: SupabaseAuth = .init()
    @Published var isLoading = false
    @Published var firstPasswordError: String? = nil
    
    var passwordRequirements: [PasswordRequirement] {
        [
            PasswordRequirement(text: "At least 8 characters", isMet: password.count >= 8),
            PasswordRequirement(text: "At least 1 uppercase letter", isMet: password.range(of: "[A-Z]", options: .regularExpression) != nil),
            PasswordRequirement(text: "At least 1 lowercase letter", isMet: password.range(of: "[a-z]", options: .regularExpression) != nil),
            PasswordRequirement(text: "At least 1 digit", isMet: password.range(of: "\\d", options: .regularExpression) != nil),
            PasswordRequirement(text: "At least 1 special character", isMet: password.range(of: "\\W", options: .regularExpression) != nil),
            PasswordRequirement(text: "Password and Re-Password must match ", isMet: password == rePassword && password.count > 0)
        ]
    }
    
    @MainActor
    func isUserSignIn() async {
        do {
            try await supabaseAuth.LoginUser()
            authState = AuthState.Signin
            
        } catch _ {
            authState = AuthState.Signout
        }
    }
    
    @MainActor
    func signup(email: String, password: String, fullName: String) async {
        do {
            isLoading = true
            if !isSignUpValid() {
                isLoading = false
                return
            }
            try await supabaseAuth.SignUp(email: email, password: password, fullName: fullName)
            authState = AuthState.Signin
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            isLoading = true
            try await supabaseAuth.SignIn(email: email, password: password)
            
            authState = AuthState.Signin
            isLoading = false
        } catch {
            print(error)
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func setFirstPasswordError() {
        if password.count == 0 {
            firstPasswordError = nil
            return
        }
        
        for passwordRequirement in passwordRequirements {
            if !passwordRequirement.isMet {
                firstPasswordError = passwordRequirement.text
                return
            }
        }
    }

    private func isSignUpValid() -> Bool {
        if fullName == "" {
            errorMessage = "Must enter a full name"
            return false
        }
        if !validEmail() {
            errorMessage = "Email is invalid"
            return false
        }
        if !validPassword() {
            errorMessage = "Password is invalid"
            return false
        }
        
        return true
    }

    private func validEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isEmailValid = email.range(of: emailRegex, options: .regularExpression) != nil
        
        return isEmailValid
    }
    
    private func validPassword() -> Bool {
        for requirement in passwordRequirements {
            if requirement.isMet == false { return false }
        }
       
        return true
    }
    
    @MainActor
    func signoutUser() async {
        do {
            try await supabaseAuth.signOut()
            authState = AuthState.Signout
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
