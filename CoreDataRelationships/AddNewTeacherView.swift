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
        //Add code
    }
}

struct AddTeacherView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTeacherView()
    }
}
