//
//  SignInWithAppleView.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 23.09.2021.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices

struct SignInWithAppleView: View {
    @State private var currentNonce: String?
    var appleLogin = SignInWithApple()

    var body: some View {
        VStack {
            SignInWithAppleButton(
                onRequest: { request in
                    let nonce = appleLogin.randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = appleLogin.sha256(nonce)
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            
                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                if (error != nil) {
                                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                                    // you're sending the SHA256-hashed nonce as a hex string with
                                    // your request to Apple.
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                print("signed in")
                            }
                            print("\(String(describing: Auth.auth().currentUser?.uid))")
                        default:
                            break
                        }
                    default:
                        break
                    }
                }
            )
        }
    }
}

struct SignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView()
    }
}
