//
//  AddNewSchool.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

enum ActiveAlertSchool {
    case first, second, zero
}

struct AddNewSchoolView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    @State private var name : String = ""
    @State private var address: String = ""
    
    @State private var showAlert : Bool = false
    @State private var activeAlert: ActiveAlertSchool = .zero
    
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
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .first:
                    return Alert(title: Text("Name is empty"), message: Text("Enter name"), dismissButton: .default(Text("OK")))
                case .second:
                    return Alert(title: Text("Address is empty"), message: Text("Enter address"), dismissButton: .default(Text("OK")))
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
        else if  self.address.isEmpty{
            self.activeAlert = .second
            self.showAlert = true
        }
        else {
            let school = School(context: dataController.container.viewContext)
            
            school.id = UUID()
            school.date = Date()
            school.name = self.name
            school.address = self.address
            
            dataController.save()
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddNewSchool_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSchoolView()
    }
}
