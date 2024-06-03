//
//  Supabase.swift
//  FiveDaily
//
//  Created by Jarred Kalina on 6/2/24.
//

import Foundation
import Supabase

class SupabaseAuth {
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://zvvgrhsrlxspxkurrdld.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp2dmdyaHNybHhzcHhrdXJyZGxkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTcwMDkzOTMsImV4cCI6MjAzMjU4NTM5M30.EFjwkCFtSHx9cUPTLP6M2Uv9NGQV6KPxswU2uumXDVo"
    )
    
    func LoginUser() async throws {
        do {
            let session = try await client.auth.session
            
        } catch {
            throw error
        }
    }
    
    func SignIn(email: String, password: String) async throws {
        do {
            try await client.auth.signIn(email: email.lowercased(), password: password)
        } catch {
            throw error
        }
    }
    
    func SignUp(email: String, password: String, fullName: String) async throws {
        do {
            try await client.auth.signUp(email: email.lowercased(), password: password, data: [
                "full_name": .string(fullName),
            ])
        } catch {
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try await client.auth.signOut()
        } catch {
            throw error
        }
    }
}
