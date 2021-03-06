//
//  Authentication.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 22.09.2021.
//

import SwiftUI
import FirebaseAuth

class Authentication: ObservableObject {
    
    @Published var signedIn = false
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}
