//
//  TeacherDetailView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 29/03/22.
//

import SwiftUI

struct TeacherDetailView: View {
    
    let teacher : Teacher
        
    //The school, principal and students objects are fetched from the teacher object
    var school : School? {
        teacher.school
    }
    var principal : Principal? {
        teacher.principal
    }
    var students : [Student] {
        teacher.students?.allObjects as? [Student] ?? []
    }
    
    var body: some View {
        Form {
            Section (header: Text("Name")) {
                List {
                    Text(teacher.name ?? "")
                }
            }
            Section (header: Text("School")) {
                List {
                    Text(school?.name ?? "")
                }
            }
            Section (header : Text ("Principal")) {
                List {
                    Text (principal?.name ?? "")
                }
            }
            Section (header: Text("Students")) {
                List {
                    ForEach (students) { student in
                        Text(student.name ?? "")
                    }
                }
            }
        }
        .navigationTitle("Teacher")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TeacherDetailView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        let teacher = Teacher(context: dataController.container.viewContext)
        teacher.name = "Sirius Black"
        
        return TeacherDetailView(teacher: teacher)
    }
}
