//
//  BooksViewModel.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 21.09.2021.
//

import FirebaseFirestore
import Foundation

class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private var dataBase = Firestore.firestore()
    
    func fetchData() {
        dataBase.collection("Book").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.books = documents.map { (queryDocumentSnapshot) -> Book in
                let data = queryDocumentSnapshot.data()
                
                let title = data["title"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                let pages = data["pages"] as? Int ?? 0
                
                return Book(author: author, title: title, pages: pages)
            }
            
        }
    }
}
