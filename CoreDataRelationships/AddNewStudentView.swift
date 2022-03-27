//
//  AddNewStudent.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

struct AddNewStudentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    @State private var name: String = ""
    @State private var age : String = ""
    @State private var standard : String = ""
    
    @State private var showAlert : Bool = false
    
    
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
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Dismiss")
                    }

                }
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button {
                        saveButton()
                    } label: {
                        Text("Save")
                    }

                }
            }
        }
    }
    func saveButton(){
        //Add code
    }
}

struct AddNewStudent_Previews: PreviewProvider {
    static var previews: some View {
        AddNewStudentView()
    }
}
