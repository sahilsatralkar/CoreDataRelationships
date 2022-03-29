//
//  AddTeacherView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

struct AddNewTeacherView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    let school : School
    
    @State private var name: String = ""
    @State private var age : String = ""
    @State private var subject : String = ""
    @State private var experience : String = ""
    
    @State private var showAlert : Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section (header: Text("Age")) {
                    TextField("Enter age", text: $age)
                }
                Section (header: Text("Subject")) {
                    TextField("Enter subject", text: $subject)
                }
                Section (header: Text("Experience")) {
                    TextField("Enter experience", text: $experience)
                }
            }
            .navigationTitle("Add new Teacher")
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss")
            }),                 trailing:
                                    Button(action: {
                saveButton()
            }, label: {
                Text("Save")
            }))
        }
    }
    
    func saveButton(){
        
        let newTeacher = Teacher(context: dataController.container.viewContext)
        newTeacher.date = Date()
        newTeacher.name = self.name
        newTeacher.age = Int16(Int(self.age) ?? 0)
        newTeacher.experience = Int16(Int(self.experience) ?? 0)
        newTeacher.school = self.school
        newTeacher.id = UUID()
        
        dataController.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct AddTeacherView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    static var school = FetchRequest<School>(entity: School.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \School.date, ascending: false)])
    static var previews: some View {
        
        AddNewTeacherView(school: school.wrappedValue.first! )
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
