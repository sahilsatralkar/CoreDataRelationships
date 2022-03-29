//
//  StudentDetailView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 29/03/22.
//

import SwiftUI

struct StudentDetailView: View {
    
    let student : Student
    
    var school : School {
        student.school!
    }
    
    var principal : Principal {
        student.principal!
    }
    
    var teachers : [Teacher] {
        student.teachers?.allObjects as! [Teacher]
    }
    
    var body: some View {
        Form {
            Section (header: Text("Name")){
                List {
                    Text(student.name ?? "")
                }
            }
            Section (header : Text("School")) {
                List {
                    Text (school.name ?? "")
                }
            }
            Section (header: Text("Principal")) {
                List {
                    Text (principal.name ?? "")
                }
            }
            Section (header : Text ("Teachers")) {
                List {
                    ForEach (teachers) { teacher in
                        Text(teacher.name ?? "")
                    }
                }
            }
        }
        .navigationTitle("Student")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct StudentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentDetailView()
//    }
//}
