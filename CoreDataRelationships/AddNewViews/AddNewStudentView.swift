//
//  AddNewStudent.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

enum ActiveAlertStudent {
    case first, second, third, zero
}

struct AddNewStudentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    @State private var name: String = ""
    @State private var age : String = ""
    @State private var standard : String = ""
    
    @State private var showAlert : Bool = false
    @State private var activeAlert: ActiveAlertStudent = .zero
    
    let school : School
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section (header : Text("Age")) {
                    TextField("Enter age", text: $age)
                }
                Section(header: Text("Standard")) {
                    TextField("Enter standard", text : $standard)
                }
            }
            .navigationTitle("Add new Student")
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
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .first:
                    return Alert(title: Text("Name is empty"), message: Text("Please enter name"), dismissButton: .default(Text("OK")))
                case .second:
                    return Alert(title: Text("Age is incorrect"), message: Text("Please enter age"), dismissButton: .default(Text("OK")))
                case .third:
                    return Alert(title: Text("Standard is incorrect"), message: Text("Please enter standard"), dismissButton: .default(Text("OK")))
                case .zero:
                    return Alert(title: Text("Incorrect data"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    func saveButton(){
        if self.name.isEmpty {
            self.activeAlert = .first
            self.showAlert = true
        }
        else if Int(self.age) == nil || self.age.isEmpty {
            self.activeAlert = .second
            self.showAlert = true
        }
        else if Int(self.standard) == nil || self.standard.isEmpty {
            self.activeAlert = .third
            self.showAlert = true
        }
        else {
            let student = Student(context: dataController.container.viewContext)
            
            student.name = self.name
            student.age = Int16(Int(self.age) ?? 0)
            student.standard = Int16(Int(self.standard) ?? 0)
            student.id = UUID()
            student.date = Date()
            student.school = self.school
            
            dataController.save()
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddNewStudent_Previews: PreviewProvider {
    static let dataController = DataController.preview
    static var previews: some View {
        let school = School(context: dataController.container.viewContext)
        AddNewStudentView(school: school)
    }
}
