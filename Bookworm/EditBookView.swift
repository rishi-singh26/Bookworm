//
//  EditBookView.swift
//  Bookworm
//
//  Created by Rishi Singh on 16/09/23.
//

import SwiftUI

struct EditBookView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 2
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    init(book: Book) {
        print(book.title!)
        print(book.rating)
        print(book.review!)
        print(book.author!)
        print(book.genre!)
        
        self.book = book
        self.title = book.title ?? ""
        self.author = book.author ?? ""
        self.rating = Int(book.rating)
        self.genre = book.genre ?? ""
        self.review = book.review ?? ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
            }
            .navigationTitle("Edit book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newBook = Book(context: moc)
                        newBook.id = book.id
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                    }
                }
            }
        }
    }
}
