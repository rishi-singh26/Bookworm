//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Rishi Singh on 16/09/23.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var isEditingBook = false
    @State private var showDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(book.genre ?? "Fantasy")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding([.top, .leading, .trailing], 7)
                    
                    RatingView(rating: .constant(Int(book.rating)))
                        .font(.caption)
                        .padding([.bottom, .leading, .trailing], 7)
                }
                .background(.ultraThinMaterial.blendMode(.darken))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(x: 5, y: -5)
            }
            .padding()
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .textSelection(.enabled)
                .padding()

        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                HStack {
                    Button {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete book", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    Divider()
                    Button {
                        isEditingBook = true
                    } label: {
                        Label("Edit book", systemImage: "pencil.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $isEditingBook) {
            EditBookView(book: book)
        }
        .alert("Alert!", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                moc.delete(book)
                try? moc.save()
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                print("canceling")
            }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
    }
}
