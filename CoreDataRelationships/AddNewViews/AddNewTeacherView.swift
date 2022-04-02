//
//  AddTeacherView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

enum ActiveAlertTeacher {
    case first, second, third, fourth, zero
}

struct AddNewTeacherView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    let school : School
    
    @State private var activeAlert: ActiveAlertTeacher = .zero
    @State private var showAlert : Bool = false
    
    @State private var name: String = ""
    @State private var age : String = ""
    @State private var subject : String = ""
    @State private var experience : String = ""
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        saveButton()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .alert(isPresented : $showAlert) {
                switch activeAlert {
                    
                case .first :
                    return Alert(title: Text("Name is empty"), message: Text("Please enter name"), dismissButton: .default(Text("OK")))
                case .second :
                    return Alert(title: Text("Age is incorrect"), message: Text("Please enter age"), dismissButton: .default(Text("OK")))
                case .third :
                    return Alert(title: Text("Subject is incorrect"), message: Text("Please enter subject"), dismissButton: .default(Text("OK")))
                case .fourth :
                    return Alert(title: Text("Experience is incorrect"), message: Text("Please enter experience"), dismissButton: .default(Text("OK")))
                case .zero :
                    return Alert(title: Text("Field is empty"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func saveButton(){
        
        //Validation for textfields
        if self.name.isEmpty {
            self.activeAlert = .first
            self.showAlert = true
        }
        else if Int(self.age) == nil || self.age.isEmpty {
            self.activeAlert = .second
            self.showAlert = true
        }
        else if self.subject.isEmpty {
            self.activeAlert = .third
            self.showAlert = true
        }
        else if Int(self.experience) == nil || self.experience.isEmpty {
            self.activeAlert = .fourth
            self.showAlert = true
        }
        
        else {
            let newTeacher = Teacher(context: dataController.container.viewContext)
            newTeacher.date = Date()
            newTeacher.name = self.name
            newTeacher.age = Int16(Int(self.age) ?? 0)
            newTeacher.experience = Int16(Int(self.experience) ?? 0)
            newTeacher.school = self.school
            newTeacher.id = UUID()
            newTeacher.principal = self.school.principal
            newTeacher.students = self.school.students
            
            dataController.save()
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddTeacherView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        let school = School(context: dataController.container.viewContext)
        
        AddNewTeacherView(school: school )
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
