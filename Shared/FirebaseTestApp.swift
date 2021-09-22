//
//  FirebaseTestApp.swift
//  Shared
//
//  Created by Michael Novosad on 21.09.2021.
//

import SwiftUI
import Firebase

@main
struct FirebaseTestApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
