//
//  LogInView.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 22.09.2021.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var yourEmail = ""
    @State private var yourPassword = ""
    
    @State private var sheetIsPresented = false
    @StateObject private var viewModel = Authentication()
    private var appleLogin = SignInWithApple()
    
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        if viewModel.signedIn {
            SuccessView()
        } else {
            VStack {
                Section {
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 2)
                .padding(5)
                VStack {
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .frame(width: 80, height: 30)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                            .foregroundColor(.blue)
                    })

                    SignInWithAppleView()
                        .frame(width: 280, height: 45, alignment: .center)
                        .padding()
                                  
                    Button(action: {
                        self.sheetIsPresented = true
                    }, label: {
                        Text("Create new account")
                            .font(.caption)
                            .foregroundColor(.blue)
                    })
                        .padding()
                }
                .sheet(isPresented: $sheetIsPresented) {
                    Section {
                        TextField("Email", text: $yourEmail)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        TextField("Password", text: $yourPassword)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    .textFieldStyle(.roundedBorder)
                    .shadow(radius: 2)
                    .padding(10)
                    Button(action: {
                        guard !yourEmail.isEmpty, !yourPassword.isEmpty else { return }
                        viewModel.signUp(email: yourEmail, password: yourPassword)
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .frame(width: 80, height: 30)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                            .foregroundColor(.blue)
                    })
                }
            }
            .padding()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
