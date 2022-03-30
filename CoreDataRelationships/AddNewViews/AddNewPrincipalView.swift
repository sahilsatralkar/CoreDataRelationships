//
//  AddPrincipalView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 27/03/22.
//

import SwiftUI

enum ActiveAlertPrincipal {
    case first, second, third, zero
}

struct AddNewPrincipalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController : DataController
    
    let school : School
    
    @State private var showAlert : Bool = false
    @State private var activeAlert : ActiveAlertPrincipal = .zero
    
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
                case .first:
                    return Alert(title: Text("Name is empty"), message: Text("Please enter name"), dismissButton: .default(Text("OK")))
                case .second:
                    return Alert(title: Text("Age is incorrect"), message: Text("Please enter an integer"), dismissButton: .default(Text("OK")))
                case .third:
                    return Alert(title: Text("Experience is incorrect"), message: Text("Please enter an integer"), dismissButton: .default(Text("OK")))
               
                case .zero:
                    return Alert(title: Text("Name is empty"), message: Text("Please enter name"), dismissButton: .cancel())
                }
            }
        }
    }
    
    func saveButton() {
        
        if self.name == "" {
            self.activeAlert = .first
            self.showAlert = true
        }
        else if Int(self.age) == nil || self.age == "" {
            self.activeAlert = .second
            self.showAlert = true
        }
        else if Int(self.experience) == nil || self.experience == ""  {
            self.activeAlert = .third
            self.showAlert = true
        }
        else {
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
}

struct AddPrincipalView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        let school = School(context: dataController.container.viewContext)
        return AddNewPrincipalView(school: school).environment(\.managedObjectContext, dataController.container.viewContext).environmentObject(dataController)
    }
}
