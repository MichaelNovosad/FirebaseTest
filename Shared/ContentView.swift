//
//  ContentView.swift
//  Shared
//
//  Created by Michael Novosad on 21.09.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var viewModel = Authentication()

    var body: some View {
        List {
            NavigationLink {
                BooksPreviewView()
            } label: {
                Text("Firebase Firestore")
            }
            NavigationLink {
                LogInView()
            } label: {
                Text("Firebase SignIn")
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
