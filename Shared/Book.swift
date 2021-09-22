//
//  Book.swift
//  FirebaseTest (iOS)
//
//  Created by Michael Novosad on 21.09.2021.
//


import Foundation

struct Book: Identifiable {
    let id = UUID()
    let author: String
    let title: String
    let pages: Int
}
