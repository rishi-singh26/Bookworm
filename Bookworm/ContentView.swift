//
//  ContentView.swift
//  Bookworm
//
//  Created by Rishi Singh on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddBookSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .listRowBackground(Color(red: 1, green: 0.38, blue: 0.38, opacity: book.rating <= 2 ? 0.2 : 0))
                        .swipeActions(edge: .leading) {
                            Button {
                                print("Editing Book")
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
//            .scrollContentBackground(.hidden)
//            .background(.indigo)
            .listStyle(.sidebar)
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            showingAddBookSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add book")
                                    .font(.headline)
                            }
                        }
                        Spacer()
                        Text("\(books.count) Books")
                            .font(.headline)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBookSheet) {
                AddBookView()
            }
            .searchable(text: $searchText)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
    
    var searchResults: FetchedResults<Book> {
        if searchText.isEmpty {
            return books
        } else {
            return books
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
