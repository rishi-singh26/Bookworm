//
//  BookDetail.swift
//  Bookworm
//
//  Created by Rishi Singh on 16/09/23.
//

import SwiftUI

struct BookDetail: View {
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
                .background(.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(x: 5, y: -5)
            }
            .padding()
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()

        }
        .navigationTitle("Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}
