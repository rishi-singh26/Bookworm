//
//  ContentView.swift
//  Bookworm
//
//  Created by Rishi Singh on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddBookSheet = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    Text(book.title ?? "Not")
                }
            }
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
            }
            .sheet(isPresented: $showingAddBookSheet) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
