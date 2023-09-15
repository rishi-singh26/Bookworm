//
//  ContentView.swift
//  Bookworm
//
//  Created by Rishi Singh on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            List(students) { student in
                Text(student.name ?? "NA")
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Add") {
                        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                        let chosenFirstName = firstNames.randomElement()!
                        let chosenLastName = lastNames.randomElement()!
                        
                        let student = Student(context: moc)
                        student.id = UUID()
                        student.name = "\(chosenFirstName) \(chosenLastName)"
                        
                        try? moc.save()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
