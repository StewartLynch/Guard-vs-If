/*:
 [< Previous](@previous)           [Home](Introduction)
 
 ## Throwing Errors and optional try
 Simplify the flow and readbility of functions using guard.  If the error from a throwing function is not important to you, consider using an optional try.
 */
/*:
 
 */

import Foundation

code(for: "Example 1") {
    // consider this API Service enum
    enum APIService {
        enum APIError: Error {
            case tooEasy
            case tooShort
            case noPassword
        }
        
        static func login(_ password: String?) throws -> String {
            if let password = password {
                if password.count < 6 {
                    throw APIError.tooShort
                }
                if password.lowercased() == "password" {
                    throw APIError.tooEasy
                }
                // OK to try to log in
                return "Logged in"
            } else {
                throw APIError.noPassword
            }
        }
    }
    
    // write a login Function that will utilize the API service's login function to pass in a password and print out the returned status string
    func login(with password: String) {
        do {
            let status = try APIService.login(password)
            print(status)
        } catch {
            print(error)
        }
    }
    
    login(with: "password")
    login(with: "pass")
    login(with: "great password")
}

code(for: "Example 2 - A complete rewrite with guard") {
    // refactor the code above replacing all if statements with guard statements and also using an optional try
    enum APIService {
        enum APIError: Error {
            case tooEasy
            case tooShort
            case noPassword
        }
        
        static func login(_ password: String?) throws -> String {
            guard let password = password else { throw APIError.noPassword }
            guard password.count >= 6 else { throw APIError.tooShort }
            guard password.lowercased() != "password" else { throw APIError.tooEasy }
            return "Logged In"
        }
    }
    
    func login(with password: String) {
        guard let status = try? APIService.login(password) else {
            print("Login Failed")
            return
        }
        print(status)
    }
    
    login(with: "password")
    login(with: "pass")
    login(with: "great password")
}
/*:
 
 [< Previous](@previous)           [Home](Introduction)
 */

