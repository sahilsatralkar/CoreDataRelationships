//
//  AddNewSchool.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

struct AddNewSchoolView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    @State private var name : String = ""
    @State private var address: String = ""
    
    @State private var showAlert : Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section (header : Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section (header: Text("Address")) {
                    TextField("Enter address", text: $address)
                }
            }
            .navigationTitle("Add new School")
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
        }
    }
    func saveButton(){
        let school = School(context: dataController.container.viewContext)
        
        school.id = UUID()
        school.date = Date()
        school.name = self.name
        school.address = self.address
        
        dataController.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}

struct AddNewSchool_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSchoolView()
    }
}
