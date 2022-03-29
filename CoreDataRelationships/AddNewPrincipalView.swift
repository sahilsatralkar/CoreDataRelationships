//
//  AddPrincipalView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

struct AddNewPrincipalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    let school : School
    
    @State private var showAlert : Bool = false
    
    @State private var name = ""
    @State private var age = ""
    @State private var experience = ""

    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Name")) {
                    TextField("Enter a name", text: $name)
                }
                Section (header: Text("Age")) {
                    TextField("Enter age", text: $age)
                }
                Section (header: Text("Experience")) {
                    TextField("Enter experience", text: $experience)
                }
            }
            .navigationTitle("Add New Principal")
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss")
            })
                                    , trailing:
                                    Button(action: {
                saveButton()
            }, label: {
                Text("Save")
            }))
        }
        
    }
    
    func saveButton() {
        let principal = Principal(context: dataController.container.viewContext)
        
        principal.id = UUID()
        principal.name = self.name
        principal.age = Int16(Int(self.age) ?? 0)
        principal.experience = Int16(Int(self.experience) ?? 0)
        principal.date = Date()
        principal.school = self.school
        
        dataController.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

//struct AddPrincipalView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewPrincipalView()
//    }
//}
