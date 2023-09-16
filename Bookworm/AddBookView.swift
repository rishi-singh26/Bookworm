//
//  AddBookView.swift
//  Bookworm
//
//  Created by Rishi Singh on 16/09/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 2
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
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
            .navigationTitle("Add book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.createdOn = Date.now
                        
                        try? moc.save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                    }
                    .disabled(saveButtonDisabled)
                }
            }
        }
    }
    
    var saveButtonDisabled: Bool {
        if isValid(string: title) && isValid(string: author) {
            return false
        }
        return true
    }
    
    func isValid(string text: String) -> Bool {
        return !text.lowercased().trimmingCharacters(in: .whitespaces).isEmpty
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
