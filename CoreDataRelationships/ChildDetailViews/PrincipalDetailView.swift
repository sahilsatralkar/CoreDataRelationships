//
//  PrincipalDetailView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 29/03/22.
//

import SwiftUI

struct PrincipalDetailView: View {
    
    let principal: Principal
    
    // The school, teachers and students objects are fetched from
    // within the principal object itself
    var school : School? {
        principal.school 
    }
    var teachers : [Teacher] {
        principal.school?.teachers?.allObjects as? [Teacher] ?? []
    }
    var students : [Student] {
        principal.school?.students?.allObjects as? [Student] ?? []
    }
    
    var body: some View {
        Form {
            Section (header: Text("Name")) {
                List {
                    Text("\(principal.name ?? "")")
                }
            }
            Section (header: Text("School")) {
                List {
                    Text("\(school?.name ?? "")")
                }
            }
            Section (header: Text("Teachers")) {
                List {
                    ForEach(teachers) { teacher in
                        Text("\(teacher.name ?? "")")
                    }
                }
            }
            Section (header: Text("Students")) {
                List {
                    ForEach(students) { student in
                        Text("\(student.name ?? "")")
                    }
                }
            }
        }
        .navigationTitle("Principal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrincipalDetailView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        let principal = Principal(context: dataController.container.viewContext)
        principal.name = "Dolores Umbridge"
        
        return PrincipalDetailView(principal: principal)
    }
}
