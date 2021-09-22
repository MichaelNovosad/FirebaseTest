//
//  BooksPreviewView.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 22.09.2021.
//

import SwiftUI
import Firebase

struct BooksPreviewView: View {
    @StateObject private var viewModel = BooksViewModel()
    
    var body: some View {
        List(viewModel.books) { book in
            VStack(alignment: .leading) {
                Text("\(book.title)")
                    .font(.subheadline)
                Text("\(book.author)")
                    .font(.headline)
                Text("\(book.pages)")
                    .font(.callout)
            }
        }
        .navigationBarTitle("Books")
        .onAppear {
            self.viewModel.fetchData()
        }
    }
}

struct BooksPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BooksPreviewView()
    }
}
