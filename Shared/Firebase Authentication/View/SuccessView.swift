//
//  SuccessView.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 22.09.2021.
//

import SwiftUI

struct SuccessView: View {
    @Environment (\.presentationMode) var presentationMode
    @StateObject private var viewModel = Authentication()
    var body: some View {
        VStack {
            Text("Congratulations! You successfully Signed In!")
            Button {
                viewModel.signOut()
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Sign Out")
                    .frame(width: 80, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                    .foregroundColor(.blue)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
